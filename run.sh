#!/usr/bin/with-contenv bashio

# Get configuration from Home Assistant
CONFIG_PATH=/data/options.json

# Parse configuration
LOG_LEVEL=$(bashio::config 'log_level')
AUDIO_DEVICE=$(bashio::config 'audio_device')
CONFIDENCE_THRESHOLD=$(bashio::config 'confidence_threshold')
OVERLAP=$(bashio::config 'overlap')
SENSITIVITY=$(bashio::config 'sensitivity')
LOCALE=$(bashio::config 'locale')
BIRDWEATHER_ID=$(bashio::config 'birdweather_id')
LATITUDE=$(bashio::config 'latitude')
LONGITUDE=$(bashio::config 'longitude')
DATABASE_TYPE=$(bashio::config 'database_type')
DATABASE_PATH=$(bashio::config 'database_path')
CLIP_PATH=$(bashio::config 'clip_path')
LOG_PATH=$(bashio::config 'log_path')
WEB_ENABLED=$(bashio::config 'web_enabled')
WEB_PORT=$(bashio::config 'web_port')
REALTIME_ENABLED=$(bashio::config 'realtime_enabled')
PRIVACY_FILTER=$(bashio::config 'privacy_filter')
NIGHT_FILTER=$(bashio::config 'night_filter')
SPECIES_LIST_ENABLED=$(bashio::config 'species_list_enabled')
RANGE_FILTER_ENABLED=$(bashio::config 'range_filter_enabled')
PROMETHEUS_ENABLED=$(bashio::config 'prometheus_enabled')
PROMETHEUS_PORT=$(bashio::config 'prometheus_port')

bashio::log.info "Starting BirdNET-Go addon..."

# Create necessary directories
mkdir -p "$(dirname "$DATABASE_PATH")"
mkdir -p "$CLIP_PATH"
mkdir -p "$LOG_PATH"

# Generate BirdNET-Go configuration file
cat > /tmp/birdnet-config.yaml << EOF
# BirdNET-Go Configuration
debug: $([ "$LOG_LEVEL" = "debug" ] && echo "true" || echo "false")

input:
  device: "$AUDIO_DEVICE"

birdnet:
  threshold: $CONFIDENCE_THRESHOLD
  overlap: $OVERLAP
  sensitivity: $SENSITIVITY
  locale: "$LOCALE"

realtime:
  enabled: $REALTIME_ENABLED
  privacy: $PRIVACY_FILTER
  night: $NIGHT_FILTER

output:
  log:
    enabled: true
    path: "$LOG_PATH"
    level: "$LOG_LEVEL"

database:
  driver: "$DATABASE_TYPE"
  datasource: "$DATABASE_PATH"

clips:
  enabled: true
  path: "$CLIP_PATH"

web:
  enabled: $WEB_ENABLED
  port: $WEB_PORT
  host: "0.0.0.0"

metrics:
  enabled: $PROMETHEUS_ENABLED
  port: $PROMETHEUS_PORT
  host: "0.0.0.0"
EOF

# Add BirdWeather configuration if ID is provided
if [ -n "$BIRDWEATHER_ID" ] && [ "$BIRDWEATHER_ID" != "" ]; then
    cat >> /tmp/birdnet-config.yaml << EOF

birdweather:
  enabled: true
  id: "$BIRDWEATHER_ID"
  location:
    latitude: $LATITUDE
    longitude: $LONGITUDE
EOF
fi

# Add location for range filtering if enabled
if [ "$RANGE_FILTER_ENABLED" = "true" ]; then
    cat >> /tmp/birdnet-config.yaml << EOF

location:
  latitude: $LATITUDE
  longitude: $LONGITUDE
EOF
fi

bashio::log.info "Configuration created, starting BirdNET-Go..."

# Change to birdnet-go directory
cd /opt/birdnet-go

# Start BirdNET-Go
if [ "$REALTIME_ENABLED" = "true" ]; then
    bashio::log.info "Starting realtime analysis..."
    ./birdnet --config /tmp/birdnet-config.yaml realtime
else
    bashio::log.info "Starting in server mode..."
    ./birdnet --config /tmp/birdnet-config.yaml
fi

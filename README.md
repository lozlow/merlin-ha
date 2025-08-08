# Home Assistant Add-on: BirdNET-Go

Real-time bird sound identification and monitoring using the BirdNET AI model. This add-on provides continuous analysis of audio input to detect and identify bird species.

## Features

- 24/7 realtime bird song analysis
- Utilizes BirdNET AI model trained with 6500+ bird species
- Local processing - no internet required for identification
- Web interface for data visualization and configuration
- Supports 40+ languages for species names
- SQLite database for storing detections
- Audio clip saving for identified birds
- BirdWeather.com integration
- Prometheus metrics endpoint
- Advanced features like Deep Detection and Live Audio Streaming

## Installation

1. Add this repository to your Home Assistant add-on store
2. Install the "BirdNET-Go" add-on
3. Configure the add-on options
4. Start the add-on
5. Access the web interface at `http://homeassistant.local:8080`

## Configuration

### Basic Options

- **log_level**: Set the logging level (trace, debug, info, warn, error, fatal, panic)
- **audio_device**: Audio input device to use (default: "default")
- **confidence_threshold**: Minimum confidence for bird detections (0.1-1.0, default: 0.8)
- **overlap**: Analysis window overlap (0.0-2.9, higher values enable Deep Detection)
- **sensitivity**: Detection sensitivity (0.0-1.5, default: 1.0)
- **locale**: Language for species names (default: "en")

### Location Settings

- **latitude**: Your location's latitude for range filtering
- **longitude**: Your location's longitude for range filtering

### Storage Settings

- **database_type**: Database type (sqlite or mysql)
- **database_path**: Path to store the SQLite database
- **clip_path**: Directory to save audio clips of detections
- **log_path**: Directory for log files

### Web Interface

- **web_enabled**: Enable web interface (default: true)
- **web_port**: Port for web interface (default: 8080)

### Monitoring & Integration

- **birdweather_id**: Your BirdWeather.com station ID
- **prometheus_enabled**: Enable Prometheus metrics endpoint
- **prometheus_port**: Port for Prometheus metrics (default: 8090)

### Filters

- **privacy_filter**: Enable privacy mode (filter out non-bird sounds)
- **night_filter**: Filter detections during night hours
- **species_list_enabled**: Use custom species list
- **range_filter_enabled**: Use geographic range filtering

## Usage

Once started, the add-on will:

1. Begin analyzing audio from the configured input device
2. Store bird detections in the database
3. Save audio clips of identified birds (if enabled)
4. Provide a web interface for viewing detections and configuration

Access the web interface at: `http://homeassistant.local:8080`

## Audio Input

The add-on can analyze audio from:

- USB microphones
- Audio interface devices
- Network audio streams
- Built-in microphones (where available)

Configure the `audio_device` option to specify which input device to use.

## Data Storage

Detection data is stored in `/share/birdnet_go/` by default:

- `detections.db`: SQLite database with all detections
- `clips/`: Audio recordings of detected birds
- `logs/`: Application log files

## BirdWeather Integration

To upload detections to BirdWeather.com:

1. Register at BirdWeather.com
2. Get your station ID
3. Set the `birdweather_id` option
4. Configure your location (latitude/longitude)

## Support

For issues and feature requests, visit: https://github.com/tphakala/birdnet-go

## License

Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International

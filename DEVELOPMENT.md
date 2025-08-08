# Development Guide

This guide will help you develop, test, and maintain the BirdNET-Go Home Assistant add-on.

## Prerequisites

- Home Assistant OS or Supervised installation
- Docker (for local testing)
- Git
- Basic knowledge of YAML, JSON, and Bash scripting

## Local Development Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/addon-birdnet-go.git
cd addon-birdnet-go
```

### 2. Local Testing with Docker

Build the add-on locally:

```bash
# Build for your current architecture
docker build -t local/birdnet-go-addon .

# Run the container for testing
docker run --rm -it \
  -p 8080:8080 \
  -v $(pwd)/test-config.json:/data/options.json \
  local/birdnet-go-addon
```

### 3. Test Configuration

Create a `test-config.json` file for testing:

```json
{
  "log_level": "info",
  "audio_device": "default",
  "confidence_threshold": 0.8,
  "overlap": 0.0,
  "sensitivity": 1.0,
  "locale": "en",
  "database_path": "/share/birdnet_go/detections.db",
  "clip_path": "/share/birdnet_go/clips",
  "log_path": "/share/birdnet_go/logs",
  "web_enabled": true,
  "web_port": 8080,
  "realtime_enabled": true
}
```

## Home Assistant Integration Testing

### 1. Add Repository to Home Assistant

1. Go to **Supervisor** → **Add-on Store** → **⋮** → **Repositories**
2. Add your repository URL: `https://github.com/yourusername/addon-birdnet-go`
3. Refresh the add-on store

### 2. Install Development Version

1. Find "BirdNET-Go" in the add-on store
2. Install the add-on
3. Configure the options
4. Start the add-on
5. Check logs for any errors

## File Structure and Responsibilities

### Configuration Files

- **config.yaml**: Main configuration (preferred format)
- **config.json**: Alternative JSON configuration
- **build.yaml**: Docker build configuration

### Scripts

- **run.sh**: Main startup script
  - Parses Home Assistant configuration
  - Generates BirdNET-Go config file
  - Starts the application

### Documentation

- **README.md**: User-facing documentation
- **DOCS.md**: Technical documentation
- **CHANGELOG.md**: Version history

## Making Changes

### 1. Updating BirdNET-Go Version

1. Check for new releases: https://github.com/tphakala/birdnet-go/releases
2. Update version in `config.yaml`, `config.json`, and `build.yaml`
3. Test the new version
4. Update `CHANGELOG.md`

### 2. Adding Configuration Options

1. Add option to `config.yaml` and `config.json` in `options` section
2. Add validation schema in `schema` section
3. Update `run.sh` to handle the new option
4. Add translations in `translations/en.json`
5. Document in `README.md`

### 3. Fixing Issues

1. Check add-on logs in Home Assistant
2. Test locally with Docker
3. Make necessary changes
4. Test again before committing

## Debugging

### View Logs

In Home Assistant:

1. Go to **Supervisor** → **BirdNET-Go** → **Log**
2. Look for error messages or warnings

### Test Audio Device

```bash
# List available audio devices in the container
docker exec -it addon_birdnet_go_container arecord -l

# Test audio recording
docker exec -it addon_birdnet_go_container arecord -f cd -t wav -d 5 test.wav
```

### Check Configuration Generation

```bash
# View generated config
docker exec -it addon_birdnet_go_container cat /tmp/birdnet-config.yaml
```

## Release Process

### 1. Version Bump

1. Update version in all configuration files
2. Update `CHANGELOG.md`
3. Commit changes

### 2. GitHub Release

1. Create a new release on GitHub
2. GitHub Actions will automatically build for all architectures
3. Images will be pushed to GitHub Container Registry

### 3. Testing

1. Install the new version in Home Assistant
2. Verify functionality
3. Check for any issues

## Architecture Support

The add-on supports three architectures:

- **amd64**: Intel/AMD 64-bit systems
- **aarch64**: ARM 64-bit systems (Raspberry Pi 4+)
- **armv7**: ARM 32-bit systems (older Raspberry Pi)

Each architecture downloads the appropriate BirdNET-Go binary during build.

## Troubleshooting

### Common Issues

1. **Audio device not found**: Check if audio hardware is properly recognized
2. **Permission denied**: Ensure proper volume mappings
3. **Build failures**: Check Docker BuildKit compatibility
4. **Configuration errors**: Validate YAML/JSON syntax

### Getting Help

- Check Home Assistant Community Forum
- Review BirdNET-Go documentation
- File issues on GitHub repository

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Maintenance

- Monitor BirdNET-Go releases for updates
- Update Home Assistant base images periodically
- Review and address security advisories
- Update documentation as needed

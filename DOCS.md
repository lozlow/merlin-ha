# Home Assistant Add-on: BirdNET-Go

This directory contains the complete structure for a Home Assistant add-on that packages the BirdNET-Go application.

## Directory Structure

```
├── .github/
│   └── workflows/
│       └── build.yaml          # GitHub Actions build workflow
├── translations/
│   └── en.json                 # English translations for UI
├── build.yaml                  # Build configuration
├── CHANGELOG.md                # Version history
├── config.json                 # Add-on configuration (JSON format)
├── config.yaml                 # Add-on configuration (YAML format)
├── Dockerfile                  # Container build instructions
├── README.md                   # Add-on documentation
└── run.sh                      # Startup script
```

## Files Description

### Core Configuration Files

- **config.yaml / config.json**: Main add-on configuration files defining options, schema, and metadata
- **build.yaml**: Specifies base images and build arguments for different architectures
- **Dockerfile**: Defines how to build the container image with BirdNET-Go

### Scripts and Documentation

- **run.sh**: Startup script that configures and launches BirdNET-Go based on user options
- **README.md**: User-facing documentation explaining features and configuration
- **CHANGELOG.md**: Version history and feature updates

### Automation and Localization

- **.github/workflows/build.yaml**: GitHub Actions workflow for automated building
- **translations/en.json**: English language strings for the configuration UI

## Key Features Implemented

1. **Multi-architecture support**: amd64, aarch64, armv7
2. **Audio device configuration**: Configurable audio input source
3. **Detection parameters**: Adjustable confidence, sensitivity, and overlap
4. **Storage management**: Configurable paths for database, clips, and logs
5. **Web interface**: Built-in web UI accessible from Home Assistant
6. **BirdWeather integration**: Optional cloud service integration
7. **Prometheus metrics**: Optional metrics endpoint for monitoring
8. **Filtering options**: Privacy, night, and range-based filtering

## Installation Process

1. Add this repository to Home Assistant as an add-on repository
2. Install the BirdNET-Go add-on from the add-on store
3. Configure the options according to your setup
4. Start the add-on
5. Access the web interface through the provided link

## Configuration Options

The add-on provides comprehensive configuration through the Home Assistant interface:

- **Audio Settings**: Device selection and input parameters
- **AI Parameters**: Confidence threshold, overlap, and sensitivity
- **Storage**: Database and file storage locations
- **Integration**: BirdWeather and Prometheus configuration
- **Filters**: Privacy, time-based, and geographic filtering

## Development Notes

- Uses the official BirdNET-Go releases from GitHub
- Downloads appropriate architecture-specific binaries during build
- Follows Home Assistant add-on best practices
- Includes proper error handling and logging
- Supports persistent data storage through Home Assistant volumes

## Next Steps

To complete the add-on setup:

1. Update the build.yaml with your actual repository information
2. Test the build process locally
3. Set up a GitHub repository for the add-on
4. Configure GitHub Actions for automated builds
5. Publish to Home Assistant Community Add-ons or your own repository

ARG BUILD_FROM
FROM $BUILD_FROM

# Install required packages
RUN apk add --no-cache \
    curl \
    wget \
    tar \
    gzip \
    ca-certificates \
    tzdata \
    alsa-lib \
    ffmpeg \
    sox \
    bash \
    jq

# Set environment variables
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Create directory structure
RUN mkdir -p /opt/birdnet-go
WORKDIR /opt/birdnet-go

# Download and install birdnet-go
ARG TARGETARCH
RUN case "${TARGETARCH}" in \
        "amd64") ARCH="x86_64" ;; \
        "arm64") ARCH="aarch64" ;; \
        "arm") ARCH="armv7l" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    LATEST_VERSION=$(curl -s https://api.github.com/repos/tphakala/birdnet-go/releases/latest | jq -r '.tag_name') && \
    echo "Downloading birdnet-go ${LATEST_VERSION} for ${ARCH}" && \
    curl -L "https://github.com/tphakala/birdnet-go/releases/download/${LATEST_VERSION}/birdnet-go_Linux_${ARCH}.tar.gz" \
        -o birdnet-go.tar.gz && \
    tar -xzf birdnet-go.tar.gz && \
    chmod +x birdnet && \
    rm birdnet-go.tar.gz

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Create data directories that will be mapped
RUN mkdir -p /share/birdnet_go/{clips,logs}

CMD ["/run.sh"]

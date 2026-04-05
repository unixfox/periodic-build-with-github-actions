FROM ghcr.io/moltis-org/moltis:latest

USER root

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    python3 \
    python3-pip \
    python3-requests \
    jq \
    git \
    nano \
    wget \
    unzip \
    ca-certificates \
    libsndfile1

# Install uv (for uvx)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    /root/.local/bin/uv tool install osm-mcp-server

# Install piper-tts
RUN pip3 install --break-system-packages piper-tts

# Clone mcp-server-public-transport
RUN git clone https://github.com/mirodn/mcp-server-public-transport.git /opt/mcp-server-public-transport
RUN git clone https://github.com/belgrano9/sncf_mcp_server /opt/sncf_mcp_server

# Setup Piper models
RUN mkdir -p /tts-models && \
    curl -L https://github.com/rhasspy/piper-samples/raw/master/en_US/lessac/medium/en_US-lessac-medium.onnx -o /tts-models/en_US-lessac-medium.onnx && \
    curl -L https://github.com/rhasspy/piper-samples/raw/master/en_US/lessac/medium/en_US-lessac-medium.onnx.json -o /tts-models/en_US-lessac-medium.onnx.json

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /home/moltis
ENTRYPOINT ["moltis"]
CMD ["--bind", "0.0.0.0", "--port", "13131"]

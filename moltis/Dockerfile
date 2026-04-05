FROM ghcr.io/moltis-org/moltis:latest

USER root

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    python3 \
    python3-pip \
    jq \
    git \
    nano \
    ca-certificates

# Install uv (for uvx)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    /root/.local/bin/uv tool install osm-mcp-server

# Clone mcp-server-public-transport
RUN git clone https://github.com/mirodn/mcp-server-public-transport.git /opt/mcp-server-public-transport
RUN git clone https://github.com/belgrano9/sncf_mcp_server /opt/sncf_mcp_server
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /home/moltis
ENTRYPOINT ["moltis"]
CMD ["--bind", "0.0.0.0", "--port", "13131"]

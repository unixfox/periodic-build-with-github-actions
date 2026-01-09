FROM node:20

WORKDIR /workspace

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    expect \
    python3 \
    python3-pip \
    jq \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install uv (for uvx)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    /root/.local/bin/uv tool install osm-mcp-server && \
    /root/.local/bin/uv tool install mcp-server-calculator && \
    /root/.local/bin/uv tool install mcp-server-fetch && \
    /root/.local/bin/uv tool install mcp-server-time
ENV PATH="/root/.local/bin:$PATH"

# Install opencode
ARG OPENCODE_VERSION=latest
RUN npm install -g opencode-ai@${OPENCODE_VERSION}

# Install MCP servers
# npx-based servers (cached by npm install -g)
RUN npm install -g \
    @karashiiro/exchange-rate-mcp \
    @browserbasehq/mcp-server-browserbase \
    @perplexity-ai/mcp-server \
    @openbnb/mcp-server-airbnb \
    synchro-bus-mcp-server \
    @playwright/mcp \
    mappy-mcp-server

# Create OpenCode directories
RUN mkdir -p /root/.config/opencode /root/.local/share/opencode

# Copy entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

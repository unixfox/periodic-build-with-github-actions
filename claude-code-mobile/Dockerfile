FROM node:20-alpine

WORKDIR /workspace

# Install required packages
RUN apk add --no-cache bash curl expect python3 py3-pip jq

# Install uv (for uvx)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    /root/.local/bin/uv tool install osm-mcp-server && \
    /root/.local/bin/uv tool install mcp-server-calculator && \
    /root/.local/bin/uv tool install mcp-server-fetch && \
    /root/.local/bin/uv tool install mcp-server-time
ENV PATH="/root/.local/bin:$PATH"

# Install claude-code
#RUN curl -fsSL https://claude.ai/install.sh | bash
RUN npm install -g @anthropic-ai/claude-code

# Install happy-coder
RUN npm install -g happy-coder

# Install MCP servers
# npx-based servers (cached by npm install -g)
RUN npm install -g mappy-mcp-server @karashiiro/exchange-rate-mcp @browserbasehq/mcp-server-browserbase @openbnb/mcp-server-airbnb @apify/actors-mcp-server synchro-bus-mcp-server

# Install GitHub MCP server binary (supports x86_64 and arm64)
RUN ARCH=$(uname -m) && \
    case $ARCH in \
        x86_64) ARCH="x86_64" ;; \
        aarch64) ARCH="arm64" ;; \
        *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac && \
    GITHUB_MCP_VERSION=$(curl -s https://api.github.com/repos/github/github-mcp-server/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -LsSf "https://github.com/github/github-mcp-server/releases/download/${GITHUB_MCP_VERSION}/github-mcp-server_Linux_${ARCH}.tar.gz" | tar -xz -C /tmp && \
    mv /tmp/github-mcp-server /root/.local/bin/ && \
    chmod +x /root/.local/bin/github-mcp-server

# Copy entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

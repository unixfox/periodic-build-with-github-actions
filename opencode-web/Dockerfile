FROM node:20-alpine

WORKDIR /workspace

# Install required packages
RUN apk add --no-cache bash curl expect python3 py3-pip jq

# Install uv (for uvx)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    /root/.local/bin/uv tool install osm-mcp-server && \
    /root/.local/bin/uv tool install mappy-mcp-server
ENV PATH="/root/.local/bin:$PATH"

# Install opencode
RUN npm install -g @anomalyco/opencode

# Install MCP servers
# npx-based servers (cached by npm install -g)
RUN npm install -g @perplexity-ai/mcp-server @openbnb/mcp-server-airbnb synchro-bus-mcp-server @playwright/mcp

# Copy entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

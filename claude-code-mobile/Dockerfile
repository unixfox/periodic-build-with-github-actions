FROM node:20-alpine

WORKDIR /workspace

# Install required packages
RUN apk add --no-cache bash curl expect python3 py3-pip

# Install uv (for uvx)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Install claude-code
#RUN curl -fsSL https://claude.ai/install.sh | bash
RUN npm install -g @anthropic-ai/claude-code

# Install happy-coder
RUN npm install -g happy-coder

# Install MCP servers
# npx-based servers (cached by npm install -g)
RUN npm install -g mappy-mcp-server @karashiiro/exchange-rate-mcp @browserbasehq/mcp-server-browserbase @openbnb/mcp-server-airbnb
# uvx-based servers (will be installed on first use, but pre-warming here)
RUN PATH="/root/.cargo/bin:$PATH" uv tool install osm-mcp-server mcp-server-calculator

# Copy entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

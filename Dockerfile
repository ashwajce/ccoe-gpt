# Multi-stage build for CCOEGPT
FROM rust:1.75-slim as builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy manifests
COPY Cargo.toml Cargo.lock ./

# Copy source code
COPY src ./src
COPY ui ./ui

# Build release binary
RUN cargo build --release

# Runtime stage
FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Create app user
RUN useradd -m -u 1000 ccoegpt

WORKDIR /app

# Copy binary from builder
COPY --from=builder /app/target/release/ccoegpt /usr/local/bin/ccoegpt

# Copy UI files
COPY --from=builder /app/ui /app/ui

# Create data directory
RUN mkdir -p /root/.ccoegpt && chown -R ccoegpt:ccoegpt /root/.ccoegpt

USER ccoegpt

EXPOSE 31327

# Run daemon
CMD ["ccoegpt", "daemon", "start"]

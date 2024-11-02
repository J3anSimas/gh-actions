FROM golang:1.23 AS builder

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN go build -v -o /usr/local/bin/app ./...

FROM debian:bookworm-slim

WORKDIR /app

# Create a non-root user and group
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy the built application

COPY --from=builder /usr/local/bin/app .

# Change ownership of the application binary
RUN chown appuser:appuser /app

# Switch to the non-root user
USER appuser
EXPOSE 8080
ENV PATH="/app:${PATH}"
CMD ["./app"]

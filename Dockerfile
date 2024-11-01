# Final stage: Run the application
FROM debian:bookworm-slim

WORKDIR /app

# Create a non-root user and group
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy the built application

COPY ./main /app/main

# Change ownership of the application binary
RUN chown appuser:appuser /app/main

# Switch to the non-root user
USER appuser
EXPOSE 8080
ENV PATH="/app:${PATH}"
CMD ["main"]


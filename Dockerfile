# Stage 1: Builder
FROM python:3.11-slim AS builder

WORKDIR /app

# Copy requirements first for better caching
COPY apps/app/requirements.txt .

# Install dependencies directly (no venv needed for distroless)
# use --target
RUN pip install --no-cache-dir --target=/app/packages -r requirements.txt


# Stage 2: Runtime with Distroless
FROM gcr.io/distroless/python3-debian12

# Set Python path to include our packages
ENV PYTHONPATH=/app/packages
ENV PYTHONUNBUFFERED=1

# Copy installed packages from builder
COPY --from=builder /app/packages /app/packages

# Set environment variables
#ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copy application code
COPY apps/app/app.py .
# If you have templates/static folders:
# COPY templates/ ./templates/
# COPY static/ ./static/

EXPOSE 5000

# No need to add "python3" distroless handles it
CMD ["app.py"]

# Mem0 OSS REST server (upstream commit 42cf18c, behind v2.0.12), packaged for Railway.
FROM python:3.12-slim
ARG MEM0_VERSION=2.0.12
WORKDIR /app
COPY requirements.txt .
RUN printf 'mem0ai==%s\n' "$MEM0_VERSION" > /tmp/constraints.txt \
  && pip install --no-cache-dir --constraint /tmp/constraints.txt -r requirements.txt \
  && rm -f /tmp/constraints.txt
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libpq5 \
  && rm -rf /var/lib/apt/lists/*
COPY . .
RUN addgroup --system mem0 && adduser --system --ingroup mem0 --home /home/mem0 mem0 \
  && mkdir -p /app/history && chown -R mem0:mem0 /app/history
USER mem0
EXPOSE 8000
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 MEM0_TELEMETRY=false
CMD ["sh", "-c", "alembic upgrade head && uvicorn main:app --host 0.0.0.0 --port 8000"]

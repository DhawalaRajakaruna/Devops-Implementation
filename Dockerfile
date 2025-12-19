# ==========================================
# STAGE 1: The Builder
# ==========================================
FROM python:3.12.3-slim as builder

WORKDIR /app

# 1. Create a virtual environment to isolate dependencies
RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


FROM python:3.12.3-slim

WORKDIR /app


COPY --from=builder /opt/venv /opt/venv


ENV PATH="/opt/venv/bin:$PATH"

# 3. Copy the application code
COPY . .

EXPOSE 8000

# 4. Run command
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
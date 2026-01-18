FROM python:3.11-slim

RUN apt-get update && apt-get install -y ffmpeg git && rm -rf /var/lib/apt/lists/*

# Install PyTorch CPU
RUN pip install torch --index-url https://download.pytorch.org/whl/cpu

# Install from source (for CPU support)
RUN git clone https://github.com/ekwek1/soprano.git /app/soprano
WORKDIR /app/soprano
RUN pip install -e .

ENV HF_HOME=/app/models
WORKDIR /app

EXPOSE 8080

# Soprano server (OpenAI-compatible)
CMD ["uvicorn", "soprano.server:app", "--host", "0.0.0.0", "--port", "8080"]

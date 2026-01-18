FROM python:3.11-slim

RUN apt-get update && apt-get install -y ffmpeg git && rm -rf /var/lib/apt/lists/*

# Install PyTorch CPU (Optimized for VPS without GPU)
RUN pip install torch --index-url https://download.pytorch.org/whl/cpu

# Install Soprano
RUN pip install soprano-tts

ENV HF_HOME=/app/models
WORKDIR /app

EXPOSE 8080

# Soprano server (OpenAI-compatible) - Listen on 8080
CMD ["uvicorn", "soprano.server:app", "--host", "0.0.0.0", "--port", "8080"]

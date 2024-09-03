FROM python:3.7-slim

RUN apt update && \
    apt install -y python3-dev gcc

# Upgrade pip to the latest version
RUN python -m pip install --upgrade pip

# Install PyTorch (stable version)
RUN pip install torch torchvision torchaudio

ADD requirements.txt .
RUN pip install -r requirements.txt
#pip install --no-cache-dir -r
ADD models models
ADD src src

# Run it once to trigger densenet download
RUN python src/app.py prepare

EXPOSE 8008

# Start the server
CMD ["python", "src/app.py", "serve"]

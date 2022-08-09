FROM python:3.8-slim

ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY requirements.txt .
COPY dev_requirements.txt .

RUN apt-cache update && \
    apt-get install -y --no-install-recommends netcat-openbsd=1.130 gcc=10.4 && \
    apt-get clean && \
    pip install --no-cache-dir -r dev_requirements.txt && \
    apt purge -y gcc && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN python manage.py collectstatic --no-input

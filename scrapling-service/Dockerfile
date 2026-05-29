FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for curl_cffi, lxml, and Playwright Chromium
RUN apt-get update && apt-get install -y \
    curl \
    libnss3 libnspr4 libatk-bridge2.0-0 libdrm2 libxkbcommon0 \
    libgbm1 libasound2 libxcomposite1 libxdamage1 libxfixes3 \
    libxrandr2 libpango-1.0-0 libcairo2 libatspi2.0-0 libcups2 \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright Chromium browser (with its system deps)
RUN playwright install --with-deps chromium

COPY . .

EXPOSE 8001

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8001"]
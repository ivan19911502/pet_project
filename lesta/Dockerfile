FROM python:3.9-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.9-slim
WORKDIR /app
COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY app.py .
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl --fail http://localhost:5000/ping || exit 1
CMD ["python", "app.py"]

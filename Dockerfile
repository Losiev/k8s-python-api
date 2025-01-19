ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY app/ .

COPY bootstrap.sh /app/bootstrap.sh
RUN chmod +x /app/bootstrap.sh

EXPOSE 8000

CMD ["/bin/bash", "-c", "/app/bootstrap.sh && uvicorn main:app --host 0.0.0.0 --port 8000"]

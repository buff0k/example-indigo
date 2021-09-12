# syntax=docker/dockerfile:1
FROM python:3.9.7-slim-bullseye
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/

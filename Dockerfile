# syntax=docker/dockerfile:1
FROM ruby:2.6.8-slim-bullseye
# update and install dependencies
RUN apt-get -y update
RUN apt-get -y install git fontconfig libjpeg62-turbo xfonts-75dpi xfonts-base >
# install wkhtmltopdf
ADD https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmlt>
RUN dpkg -i /tmp/wkhtmltox_0.12.6-1.buster_amd64.deb
# Set Python Buffered
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY . /code/
RUN gem install bundler
RUN bundle update --bundler
RUN bundle install
#RUN python3 -m venv env
#RUN env/bin/activate &&
#RUN pip3 install --upgrade pip
#RUN pip3 install wheel
RUN pip3 install -r requirements.txt
RUN python3 manage.py migrate
RUN python3 manage.py update_countries_plus
RUN python3 manage.py loaddata languages_data.json.gz

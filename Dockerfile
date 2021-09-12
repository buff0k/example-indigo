# syntax=docker/dockerfile:1
FROM python:3.9.7-slim-bullseye
RUN apt-get -y update
RUN apt-get -y install git fontconfig libjpeg62-turbo xfonts-75dpi xfonts-base poppler-utils libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
ADD https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb /tmp
RUN dpkg -i /tmp/wkhtmltox_0.12.6-1.buster_amd64.deb
RUN rm wkhtmltox_0.12.6-1.buster_amd64.deb
ADD curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer /tmp
RUN /tmp/rbenv-installer
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN source ~/.bashrc
RUN rbenv install 2.6.8
RUN rbenv global 2.6.8
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY Gemfile /code/
COPY Gemfile.lock /code/
RUN gem install bundler
RUN bundle install
COPY . /code/
# syntax=docker/dockerfile:1
FROM python:3.9.7-slim-bullseye
# update and install dependencies
RUN apt-get -y update
RUN apt-get -y install git fontconfig libjpeg62-turbo xfonts-75dpi xfonts-base poppler-utils libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev wget
# install wkhtmltopdf
ADD https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb /tmp
RUN dpkg -i /tmp/wkhtmltox_0.12.6-1.buster_amd64.deb
# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh
# install ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# Set to Ruby 2.6.8
RUN rbenv install 2.6.8
RUN rbenv rehash
RUN rbenv local 2.6.8
# Set Python Buffered
ENV PYTHONUNBUFFERED=1
WORKDIR /indigo
COPY requirements.txt /indigo/
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
COPY Gemfile /indigo/
COPY Gemfile.lock /indigo/
RUN gem install bundler
RUN bundle install
COPY . /indigo/

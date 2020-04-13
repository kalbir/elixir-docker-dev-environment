FROM elixir:slim
MAINTAINER Kalbir Sohi <kalbir@gmail.com>

# Make sure we have sudo 
RUN apt-get update \
    && apt-get -y install sudo \
    && apt-get -y install curl \
    && apt-get -y install apt-utils \
    && apt-get -y install inotify-tools
# Create an app directory to store our files in
ADD . /app

# Install the Phoenix (phx) archive
RUN mix local.hex --force \
    && mix local.rebar --force
RUN mix archive.install hex phx_new 1.4.16 --force

# Install node (needed for webpack if you use it)
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

WORKDIR /app
EXPOSE 4000
CMD ["/bin/bash"]

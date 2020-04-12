FROM elixir:latest
MAINTAINER Kalbir Sohi <kalbir@gmail.com>

# Make sure we have sudo 
RUN apt-get update \
    && apt-get -y install sudo 

# Create an app directory to store our files in
ADD . /app

# Install the Phoenix (phx) archive
RUN mix local.hex --force \
    && mix local.rebar --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

# Install node (needed for webpack if you use it)
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

WORKDIR /app
EXPOSE 4000
CMD ["/bin/bash"]

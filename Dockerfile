FROM elixir:latest
MAINTAINER Kalbir Sohi <kalbir@gmail.com>

# Make sure we have sudo 
RUN apt-get update && \
      apt-get -y install sudo 

# Create an app directory to store our files in
ADD . /app

# Install the Phoenix (phx) archive
RUN mix local.hex --force \
    && mix local.rebar --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

# Install node (needed from brunch if you use it)
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && sudo apt-get install -y inotify-tools nodejs

WORKDIR /app
EXPOSE 4000
CMD ["/bin/bash"]

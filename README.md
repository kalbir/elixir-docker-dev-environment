# Local dev environments for Elixir

This is a setup for local dev environments for elixir. The aim is to have a repeatable process for setting up and developing on new elixir projects independently of the local machine.

## Dependencies

* Docker

## How I work

For local development, I create a docker image called `elixir-env` from the `Dockerfile` in this repo. All the work I do I do it from an interative terminal in this docker container. This means that I know that I can land on any machine that has docker and get going with writing elixir code.  

## Creating new projectss

In this repo are two files: a `Dockerfile` and a `docker-compose.yml` file. To create a new phoenix project you take the following steps:

1. Clone this repo.

2. `docker build . -t elixir-env` - this creates an image from the Dockerfile that has elixir and phoenix installed on it. This will be our default environment for both building new projects and working on those projects (e.g. in `iex`).

3. Change directory to wherever you want to create your new project and run `docker run --interactive --tty --rm --volume $(pwd):/app elixir-env` - this drops you onto a command prompt on that container. 

4. Depending on what kind of project you are creating, run the following:

    - `Phoenix:` `mix phx.new new_project --app new_project --no-brunch` - this creates the `new_project` phoenix project (I'm a fan of `--no-brunch`). 
    
    - `Mix:` `mix new new_project`  
    
5. `exit` the container - you will have a full `new_project` directory. Probably time for a `git init`. 

## Mix projects

For mix based projects, we can then start an iex session by:

1. In our `new_project` directory, run `docker run --interactive --tty --rm --volume $(pwd):/app elixir-env`. I've made this part of a `Makefile` so that it is easier to remember.

2. `iex -S mix` or `mix test` etc, depending on what you want to do.

## Phoenix projects

6. For `Phoenix` projects, copy the `docker-compose.yml` file from from this repo to the new project you have created.  

7. `docker compose build` - to build the images that docker compose will use. This will include a web image and a postgres image.

8. Edit the `dev.exs` config in the phoenix app so that the settings match those for postgres. *KEY POINT*: you need to change the `host` declaration from `localhost` to `db` for docker networking to work.

9. `docker compose up` - will start the phoenix app and the postgres container and all being well, you can start development. Phoenix will be running on `localhost:4000`.

10. `docker run --interactive --tty --rm --volume $(pwd):/app elixir-env` will give you an elixir environment where you can run mix tasks or an `iex` session.`

## To Do

Change the default postgres user/password/database on app creation

FIX: I need to include that package that lets you do hot reloads on Linux\n"

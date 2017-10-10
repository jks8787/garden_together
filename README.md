# GardenTogether

## App purpose:

* an app to create garden topics and comment on the with other users live
* based on work from ElixirConf US 2017 Training
* written to explore into Elixir’s Plug library, components of Phoenix’s Router & Controller layers as well as PubSub layer for realtime functionality.

## Dependencies needed:

* Homebrew => https://brew.sh/
* Elixir 1.5.1  and Erlang 20.0=> https://elixir-lang.org/install.html
* Hex => `mix local.hex`
* Rebar => `mix local.hex`
* Node => `brew install node`
* PostgreSQL => https://wiki.postgresql.org/wiki/Detailed_installation_guides
* gcc => `brew install gcc`
* make => `brew install make`

## App set up:

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Learn more About Phoenix:

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
  * Deployment Guides: http://www.phoenixframework.org/docs/deployment

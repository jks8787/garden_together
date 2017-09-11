use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :garden_together, GardenTogetherWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :garden_together, GardenTogether.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "garden_together_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

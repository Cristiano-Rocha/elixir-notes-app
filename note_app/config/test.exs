import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :note_app, NoteAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "JXAVRJB4J9HoyQmwWSkRq+SGs288UOZbya9FGkvKKZwqGTwdwYK1JY3rAs9jvn9f",
  server: false

# In test we don't send emails.
config :note_app, NoteApp.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

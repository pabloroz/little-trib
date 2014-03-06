require "cuba"
require "cuba/mote"
require "ohm"
require "rack/protection"
require "shield"
require "scrivener"

APP_KEY = ENV.fetch("APP_KEY")
APP_SECRET = ENV.fetch("APP_SECRET")
REDIS_URL = ENV.fetch("REDIS_URL")

Cuba.plugin(Cuba::Mote)
Cuba.plugin(Shield::Helpers)

Cuba.use(Rack::Session::Cookie, key: APP_KEY, secret: APP_SECRET)
Cuba.use(Rack::Static, urls: %w[/js /css /img], root: "./public")

Cuba.use(Rack::Protection)
Cuba.use(Rack::Protection::RemoteReferrer)

Ohm.redis = Redic.new(REDIS_URL)

Dir["./models/**/*.rb"].each  { |f| require(f) }
Dir["./filters/**/*.rb"].each { |f| require(f) }
Dir["./helpers/**/*.rb"].each { |f| require(f) }
Dir["./routes/**/*.rb"].each  { |f| require(f) }

Cuba.define do
  on "admin" do
    run Admins
  end

  on default do
    run Guests
  end
end
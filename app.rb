require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "binding_of_caller"

use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')

get("/") do
  @square = params.fetch("number", 0).to_i
  @results = []
  
  @square.times do
    squared = @square * @square
    
    @results.push(squared)
  end

  erb(:homepage)
end

get("/square/new") do
  erb(:homepage)
end

get("/square/results") do
  erb(:results)
end

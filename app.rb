require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "binding_of_caller"

use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')

get("/") do
  erb(:homepage)
end

get("/square/new") do
  erb(:homepage)
end

get("/square/results") do
  @number = params.fetch("number", 0).to_f
  @result = @number * @number
  erb(:results)
end

get("/square_root/new") do
  erb(:homepageroot)
end

get("/square_root/results") do
  @number = params.fetch("number", 0).to_f
  @resultsqrt = Math.sqrt(@number)
  erb(:resultsqrt)
end

get("/payment/new") do
  erb(:homepagepay)
end

get("/payment/results") do
  @apr = params.fetch("user_apr", 0).to_f
  @pv = params.fetch("user_pv", 0).to_f
  @years = params.fetch("user_years", 0).to_i
  
  ptop = (@apr/ 100.0 / 12) * @pv
  pbottom = (1 - ((1 + @apr / 100.0 / 12) ** (-@years * 12)))

  @payment = ptop / pbottom 
  @paymentr = @payment.round(4)
  @paymentc = @paymentr.to_fs(:currency)
  @aprp = "#{(@apr).round(4)}%"

  erb(:resultspay)
end

get("/random/new") do
  erb(:homepagerand)
end

get("/random/results") do
  @min = params.fetch("user_min").to_f
  @max = params.fetch("user_max").to_f

  @resultrand = rand(@min...@max)
  erb(:resultsrand)
end

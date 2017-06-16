require 'sinatra'
require "sinatra/reloader"

set :number, rand(1..100)

def check_guess(guess)
  diff = guess - settings.number
  if guess.zero?
    ""
  elsif guess > settings.number && diff > 5
    "Way too high!"
  elsif guess < settings.number && diff < -5
    "Way too low!"
  elsif guess > settings.number
    "Too high!"
  elsif guess < settings.number
    "Too low!"
  else
    "You got it right!"
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess.to_i)
  erb :index, :locals => {:number => settings.number, :message => message, :guess => guess}
end

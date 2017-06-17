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

def background(message)
  case message
  when "Way too high!" || "Way too low!"
    "#ff0000"
  when "Way too low!"
    "#ff0000"
  when "Too high!" || "Too low!"
    "#ff8282"
  when "Too low!"
    "#ff8282"
  when "You got it right!"
    "#0ad818"
  else
    "white"
  end
end

def cheating?
  params['cheat'] == "true"
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess.to_i)
  cheater = cheating?
  background = background(message)
  erb :index, :locals => {:number => settings.number, :message => message,
                          :guess => guess, :background => background,
                          :cheater => cheater}
end

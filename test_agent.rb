# encoding: UTF-8
require './simsimi_agent'

bot = SimsimiAgent.new

while true
  printf "Me: "
  str = gets.chomp
  printf "Bot: " + bot.chat(str) + "\n"
end 
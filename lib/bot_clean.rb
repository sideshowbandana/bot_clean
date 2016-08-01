require "bot_clean/version"
require "bot_clean/position"
require "bot_clean/bot"
require "bot_clean/board"
require "bot_clean/runner"
require "bot_clean/cell"

module BotClean
  def run
    Runner.new.run
  end
  module_function :run
end



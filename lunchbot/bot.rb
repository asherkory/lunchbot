module Lunchbot
  class Bot < SlackRubyBot::Bot
    help do
      title "Lunchbot"
      desc "A bot providing lunchtime assistance."
    end

    command "help" do |client, data, match|
      user_command = match[:expression]
      if user_command.nil?
        help_text = SlackRubyBot::Commands::Support::Help.instance.bot_desc_and_commands.join("\n") +
          SlackRubyBot::Commands::Support::Help.instance.other_commands_descs.join("\n") +
          "\n\nTo get help about a command, use *help <command>*"
      else
        command_attributes = SlackRubyBot::Commands::Support::Help.instance.find_command_help_attrs(user_command)
        help_text = "*#{command_attributes.command_name}*\n" +
          command_attributes.command_desc + "\n" + command_attributes.command_long_desc
      end
      client.say(channel: data.channel, text: help_text)
    end

    SlackRubyBot::Client.logger.level = Logger::WARN
  end
end
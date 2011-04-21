class HelpCommand < CommandBase
  def execute!
    shell.commands.show_help
  end
end
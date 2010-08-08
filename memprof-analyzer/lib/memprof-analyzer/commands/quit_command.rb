class QuitCommand
  def initialize( command_line )
  end

  def execute!
    Kernel.exit
  end
end
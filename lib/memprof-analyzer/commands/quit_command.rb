class QuitCommand < CommandBase
  def execute!
    Kernel.exit
  end

end
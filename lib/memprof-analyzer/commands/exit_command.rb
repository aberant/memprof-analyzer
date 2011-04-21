class ExitCommand < CommandBase
  def execute!
    Kernel.exit
  end

end
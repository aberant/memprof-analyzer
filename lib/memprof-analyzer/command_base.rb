class CommandBase
  attr_reader :db, :user_input, :shell

  def self.help
  end

  def initialize( db, user_input, shell = nil )
    @db = db
    @user_input = user_input
    @shell = shell
    after_initialize if respond_to?(:after_initialize)
  end
end

# internal commands
class UnknownCommand < CommandBase
  def execute!
    puts "unknown command"
  end
end

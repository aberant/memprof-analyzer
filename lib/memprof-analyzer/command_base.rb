class CommandBase
  attr_reader :db, :user_input

  def initialize( db, user_input )
    @db = db
    @user_input = user_input
    after_initialize if respond_to?(:after_initialize)
  end
end

# internal commands
class UnknownCommand < CommandBase
  def execute!
    puts "unknown command"
  end
end
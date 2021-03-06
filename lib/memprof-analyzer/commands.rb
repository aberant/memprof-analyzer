class Commands
  def initialize()
    @commands = Hash.new(UnknownCommand)
  end

  def load_commands
    command_dir = File.expand_path( File.join( File.dirname( __FILE__ ), "commands"))
    search_glob = File.join( command_dir, "*_command.rb")

    Dir[search_glob].each do |file|
      command_file = File.basename( file, ".rb")
      require File.join(command_dir, command_file )
      register_command( command_file )
    end
  end

  def register_command( command_file_name )
    command_name = command_file_name.match(/(\w+)_command/)[1]
    command_klass = command_file_name.camelize.constantize
    @commands[ command_name ] = command_klass
  end

  def find_command( command_name )
    @commands[ command_name ]
  end

  def to_a
    @commands.keys
  end

  def show_help
    max = @commands.keys.collect(&:length).max

    puts "Commands:"
    @commands.keys.sort.each do |c|
      puts "  #{c.ljust(max)} #{find_command(c).help}"
    end
  end
end
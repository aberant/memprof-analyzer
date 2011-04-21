class InteractiveShell
  attr_reader :commands

  def initialize( db_conn )
    @db_conn = db_conn

    @commands = Commands.new
    @commands.load_commands
    @abbreviations = @commands.to_a.abbrev
  end

  def run!
    while line = grab_line
      next if line.empty?
      command_klass = @commands.find_command( @abbreviations[ line.first ])
      command_klass.new( @db_conn, line, self ).execute!
    end
  end

  def grab_line
    Readline.readline("> ", true).strip.split(" ")
  end
end
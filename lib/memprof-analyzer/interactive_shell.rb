class InteractiveShell
  def initialize( db_conn )
    @commands = %w( quit inspect search references ).abbrev
    @db_conn = db_conn
  end

  def run!

    while line = grab_line
      case @commands[line.first]

      when "quit"
        QuitCommand.new( @db_conn, line ).execute!
      when "search"
        SearchCommand.new( @db_conn, line ).execute!
      when "inspect"
        InspectCommand.new( @db_conn, line).execute!
      when "references"
        @db["rails_ref"].find("refs" => line[1]).each do |obj|
          @db["rails"].find("_id" => obj["_id"]).each do |rails_item|
            puts "#{rails_item["_id"]} - #{rails_item["type"]} #{rails_item["name"]}"
          end
        end
      else
        p "unknown command"
      end

    end
  end

  def grab_line
    Readline.readline("> ", true).strip.split(" ")
  end

end
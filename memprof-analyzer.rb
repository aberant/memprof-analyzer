require 'mongo'
require 'json'
require 'readline'
require 'abbrev'
require 'yaml'

require 'memprof-analyzer/entry'
require 'memprof-analyzer/json_ref_formatter'
require 'memprof-analyzer/reports/reference_report'
require 'memprof-analyzer/reports/count_report'




db = Mongo::Connection.new("localhost").db("memprof")
rails = db["rails"]
rails_ref = db["rails_ref"]


def grab_line
  Readline.readline("> ", true).strip.split(" ")
end

commands = %w( quit inspect search references ).abbrev


stty_save = `stty -g`.chomp
trap('INT') { system('stty', stty_save); exit }



while line = grab_line
  case commands[line.first]

  when "quit"
    exit
  when "search"
    rails.find(line[1].to_sym => line[2]).each{|obj| y obj; puts }

  when "inspect"
    id = line[1]
    rails.find("_id" => id).each{|obj| y obj }
  when "references"
    rails_ref.find("refs" => line[1]).each do |obj|
      rails.find("_id" => obj["_id"]).each do |rails_item|
        puts "#{rails_item["_id"]} - #{rails_item["type"]} #{rails_item["name"]}"
      end
    end
  else
    p "unknown command"
  end

end


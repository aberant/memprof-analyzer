require 'mongo'
require 'json'
require 'readline'
require 'abbrev'
require 'yaml'

require 'memprof-analyzer/entry'
require 'memprof-analyzer/database_connection'

require 'memprof-analyzer/json_ref_formatter'
require 'memprof-analyzer/reports/reference_report'
require 'memprof-analyzer/reports/count_report'


# load commands
Dir["#{File.dirname(__FILE__)}/memprof-analyzer/commands/*_command.rb"].each do |file|
  require "memprof-analyzer/commands/#{ File.basename( file, ".rb") }"
end

require 'memprof-analyzer/interactive_shell'






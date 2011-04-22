class ImportCommand < CommandBase
  def self.help
    "Import the specified JSON file"
  end

  def after_initialize
    @file = user_input[1..-1].join(" ")
  end

  def execute!
    return puts "missing file" if @file.nil?

    # Redirect STDOUT to STDERR (1>&2), so it writes to the screen
    # and is not captured by the backticks.
    `mongoimport -d memprof -c rails --file #{File.expand_path(@file)} --drop --upsert 1>&2`
  end

end
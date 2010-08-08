class DatabaseConnection
  def initialize( options )
    @db = Mongo::Connection.new(options[:host]).db(options[:database])
    @memprof_collection = @db[(options[:collection] || "rails")]
    @reference_collection = @db[(options[:reference] || "rails_ref")]
  end

  def memprof
    @memprof_collection
  end

  def references
    @reference_collection
  end

end
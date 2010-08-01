class ReferenceReports
  ITEMS = [ {:type => "module",},
            {:type => "iclass",},
            {:type => "class",},
            {:type => "hash",},
            {:type => "array",},
            {:class => "Proc" }]

  def self.build_all!
    ITEMS.each do |item|
      build!( item )
    end
  end

  def self.build!( options => {} )
    db = Mongo::Connection.new( "localhost" ).db( "memprof" )
    rails = db["rails"]

    result = rails.find( options )
    result.each do |row|
      entry = Entry.new( row )
      json = JsonRefFormatter.new(entry).to_json
      puts json if json
    end
  end
end
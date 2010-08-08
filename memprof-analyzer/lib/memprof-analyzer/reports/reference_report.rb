class ReferenceReport
  ITEMS = [ {:type => "module"},
            {:type => "iclass"},
            {:type => "class"},
            {:type => "hash"},
            {:type => "array"},
            {:class => "Proc" }]

  def self.build_all!( collection )
    ITEMS.each do |item|
      build!( collection, item )
    end
  end

  def self.build!( collection, options = {} )
    result = collection.find( options )
    result.each do |row|
      entry = Entry.new( row )
      json = JsonRefFormatter.new(entry).to_json
      puts json if json
    end
  end
end
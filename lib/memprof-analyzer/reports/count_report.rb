class CountReport
  def self.count_by_type( collection )
    count_query(collection, "type")
  end

  def self.count_by_class_name( collection )
    count_query( collection, "class_name")
  end

  def self.count_by_file_and_line( collection )
    count_query( collection, ["file", "line"])
  end

private
  def self.count_query(collection, key)
    collection.group(
      [*key], # key
      {}, # condition
      {:count => 0}, # initial
      "function(obj, out) { out.count++ }" # reduce js function
    )
  end
end
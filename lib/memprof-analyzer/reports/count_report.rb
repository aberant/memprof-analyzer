class CountReport
  def self.count_by_type( collection )
    build( collection, "type" )
  end

  def self.count_by_class_name( collection )
    build( collection, "class_name" )
  end

  def self.count_by_file( collection )
    build( collection, "file" )
  end

  def self.count_by_file_and_line( collection )
    build( collection, ["file", "line"] )
  end

private
  def self.build(collection, key)
    key = [*key]
    raw_counts = count_query(collection, key)
    raw_counts.each_with_object({}) do |raw, hash|
      final_key = key.map{|k| raw[k] }.join(":")
      hash[final_key] = raw["count"]
    end
  end

  def self.count_query(collection, key)
    collection.group(
      :key => key,
      :initial => {:count => 0},
      :reduce => "function(obj, out) { out.count++ }"
    )
  end
end
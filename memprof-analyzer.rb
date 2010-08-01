require 'mongo'
require 'json'

require 'memprof-analyzer/entry'
require 'memprof-analyzer/json_ref_formatter'
require 'memprof-analyzer/reference_reports'


def each_row_for_type( type, collection )
  result = collection.find( :type => type )
  result.collect do |row|
    yield row
  end.compact
end

def each_row_for_class_name( class_name, collection )
  result = collection.find( :class_name => class_name )
  result.collect do |row|
    yield row
  end.compact
end

def array_references( collection )
  each_row_for_type( "array", collection ) do |row|
    JsonRefFormatter.new(ArrayEntry.new(row)).to_json
  end
end

def hash_references( collection )
  each_row_for_type( "hash", collection ) do |row|
    JsonRefFormatter.new(HashEntry.new(row)).to_json
  end
end

def class_references( collection )
  each_row_for_type( "class", collection ) do |row|
    JsonRefFormatter.new(ClassEntry.new(row)).to_json
  end
end

def iclass_references( collection )
  each_row_for_type( "iclass", collection ) do |row|
    JsonRefFormatter.new(IClassEntry.new(row)).to_json
  end
end

def module_references( collection )
  each_row_for_type( "module", collection ) do |row|
    JsonRefFormatter.new(ModuleEntry.new(row)).to_json
  end
end

def node_references( collection )
  each_row_for_type( "node", collection ) do |row|
    node = NodeEntry.new(row)
    JsonRefFormatter.new(node).to_json
  end
end



db = Mongo::Connection.new("localhost").db("memprof")
rails = db["rails"]

# result = rails.find( :type => "data" )
# result.each do |row|
#   entry = Entry.new( row )
#   json = JsonRefFormatter.new(entry).to_json
#   puts json if json
# end

# result = rails.find( "_id" => "0x4728270")
# while result.count > 0
#   entry = result.to_a.first
#   puts entry.inspect
#   id =  entry["super"]
#   result = rails.find( "_id" => id )
# end
result = rails.find( "_id" => "0x609af78")
while result.count > 0
  entry = result.to_a.first
  puts entry.inspect
  id =  entry["super"]
  result = rails.find( "_id" => id )
end


#
# puts module_references( rails )

# each_row_for_class_name( "Proc", rails ) do |row|
#   # puts row # if node.data?
#   node = ProcEntry.new(row)
#   puts JsonRefFormatter.new(node).to_json
# end
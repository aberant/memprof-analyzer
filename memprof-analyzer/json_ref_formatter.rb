class JsonRefFormatter
  def initialize( entry )
    @entry = entry
  end

  def to_json
    Hash["_id", @entry.memprof_id, "refs", @entry.references].to_json unless @entry.references.empty?
  end
end
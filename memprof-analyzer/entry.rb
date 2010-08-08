# entry reference extractor
class Entry
  attr_reader :data, :memprof_id

  def initialize( ruby_info )
    @memprof_id = ruby_info["_id"]
    @json = ruby_info.clone
    @json.delete("_id")
    @json.freeze
  end

  def references
    @json.inject([]) do |accum, hash|
      hash_value = hash.last

      refs =
      case
      when direct_reference?( hash_value )
        # there are some node references that also
        # have junk after the reference address
        [hash_value.match(/^(0x[0-9a-f]*)/)[1]]

      when hash_references?( hash_value )
        references_from_hash( hash_value )

      when array_references?( hash_value)
        references_from_array( hash_value )
      end

      accum.push( *refs )
    end
  end

private
  def direct_reference?( reference )
    reference.is_a?( String ) && reference.match(/^(0x[0-9a-f]*)/)
  end

  def hash_references?( hash )
    hash.is_a?( Hash ) && hash.values.any?{|v| v.is_a?(String) && v.match(/^(0x[0-9a-f]*)/)}
  end

  def array_references?( array )
    array.is_a?(Array) && array.any?{|item| item && item.is_a?(String) && item.match(/^(0x[0-9a-f]*)/)}
  end

  def references_from_hash( hash )
    hash.to_a.flatten.select do |item|
      direct_reference?( item )
    end
  end

  def references_from_array( array )
    array.select do |item|
      direct_reference?( item )
    end
  end
end
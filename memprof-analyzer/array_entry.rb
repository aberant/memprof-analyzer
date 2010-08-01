class ArrayEntry < Entry
  def references?
    data_present? &&
    @data.first.class == String &&
    @data.first.match(/^0x/)
  end

  def references
    @data
  end
end
class HashEntry < Entry
  def references?
    data_present? && @data.flatten.any?{|item| item.class == String && item.match(/^0x/)}
  end

  def references
    @data.flatten.select{|data| data.class == String && data.match(/^0x/)} if @data
  end
end
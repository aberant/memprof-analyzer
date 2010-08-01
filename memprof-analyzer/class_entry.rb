class ClassEntry < Entry
  def references?
    data_present? && @data.flatten.any?{|item| item.class == String && item.match(/^0x/)}
  end

  def references
    @data.flatten.select{|data| data.class == String && data.match(/^0x/)} if @data
  end

  def pull_data_from_info(info)
    info["ivars"]
  end
end
class NodeEntry < Entry
  def references?
    data_present? && @data.any?{|item| item.class == String && item.match(/^0x/)}
  end

  def references
    @data.select{|data| data.class == String && data.match(/^0x/)} if @data
  end

  def pull_data_from_info(info)
    result = []
    ["n1", "n2", "n3"].each do |item|
      if info[item] && info[item].class == String && info[item].match(/^0x\d.*$/)
        reference = info[item].match(/^(0x[0-9a-f]*)/)[1]
        result << reference if reference
      end
    end
    result
  end
end
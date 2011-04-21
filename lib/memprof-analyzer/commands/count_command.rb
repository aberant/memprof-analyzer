class CountCommand < CommandBase
  def self.help
    "Show counts by type. Valid types are: #{report_types.sort.join(", ")}"
  end

  def self.report_types
    CountReport.singleton_methods.select{|meth| meth.match(/count_by_/)}.collect{|r| r.to_s[9..-1]}
  end

  def after_initialize
    @rails = db.memprof
    @report_type = user_input[1]
  end

  def execute!
    return puts "invalid count report type" unless self.class.report_types.include?( @report_type )

    raw_counts = CountReport.send("count_by_#{@report_type}", @rails)
    count_hash = raw_counts.map {|k, v| Hash[k, v]}
    result = count_hash.sort{|a,b| b.values.first <=> a.values.first }
    result.each {|r| puts r.inspect }
  end

end
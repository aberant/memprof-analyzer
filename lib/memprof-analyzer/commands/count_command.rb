class CountCommand
  def initialize( db, user_input )
    @rails = db.memprof
    @report_type = user_input[1]
  end

  def execute!
    count_reports = CountReport.singleton_methods.select{|meth| meth.match(/count_by_/)}
    return puts "invalid count report type" unless count_reports.include?( "count_by_#{@report_type}".to_sym )

    raw_counts = CountReport.send("count_by_#{@report_type}", @rails)
    count_hash = raw_counts.map {|r| Hash[r["class_name"], r["count"]]}
    result = count_hash.sort{|a,b| b.values.first <=> a.values.first }
    result.each do |r|
      puts r.inspect
    end
  end

end
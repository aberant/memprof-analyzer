class InspectCommand
  def initialize( db, user_input )
    @rails = db.memprof
    @search_id = user_input[1]
  end
  def execute!
    @rails.find("_id" => @search_id).each{|obj| puts obj }
  end
end
class SearchCommand < CommandBase
  def after_initialize
    @rails = db.memprof
    @search_key = user_input[1].to_sym
    @search_data = user_input[2]
  end
  
  def execute!
    @rails.find(@search_key => @search_data).each{|obj| puts obj; puts }
  end

end
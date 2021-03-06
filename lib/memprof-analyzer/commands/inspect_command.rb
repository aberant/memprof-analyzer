class InspectCommand < CommandBase
  def self.help
    "Show the object with the specified id"
  end

  def after_initialize
    @rails = db.memprof
    @search_id = user_input[1]
  end

  def execute!
    @rails.find("_id" => @search_id).each{|obj| puts obj }
  end
end
class ReferencesCommand < CommandBase
  def after_initialize
    @rails = db.memprof
    @refs = db.references

    @search_id = user_input[1]
  end

  def execute!
    @refs.find( "refs" => @search_id ).each do |ref_obj|
      @rails.find("_id" => ref_obj["_id"]).each do |rails_item|
        puts "#{rails_item["_id"]} - #{rails_item["type"]} #{rails_item["name"]}"
      end
    end
  end

end
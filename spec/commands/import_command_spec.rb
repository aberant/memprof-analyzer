require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe ImportCommand do
  it "should import a file via mongoimport" do
    user_input = ["import", "/path/to/file.json"]
    db = mock( "db")

    command = ImportCommand.new( db, user_input )

    command.should_receive(:`).with(/^mongoimport.+\/path\/to\/file\.json/)
    command.execute!
  end

  it "should import a file with spaces via mongoimport" do
    user_input = ["import", "/path/to", "the/file.json"]
    db = mock( "db")

    command = ImportCommand.new( db, user_input )

    command.should_receive(:`).with(/^mongoimport.+\/path\/to the\/file\.json/)
    command.execute!
  end
end
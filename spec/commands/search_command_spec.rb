require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe SearchCommand do
  it "searches mongo based on user input" do
    user_input = ["search", "type", "class"]

    db = mock("db")
    connection = mock("connection" )
    connection.should_receive(:memprof).and_return( db )

    command = SearchCommand.new( connection, user_input )

    db.should_receive("find").with(:type => "class").and_return( [] )
    command.execute!
  end
end

require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe InspectCommand do
  it "displays information about the object you specify" do
    user_input = ["inspect", "0x12345"]

    db = mock("db")
    connection = mock( "connection" )
    connection.should_receive(:memprof).and_return( db )

    command = InspectCommand.new( connection, user_input )

    db.should_receive( :find ).with( "_id" => "0x12345" ).and_return( [] )
    command.execute!
  end
end

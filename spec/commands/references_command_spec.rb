require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe ReferencesCommand do
  it "should find all references to an object id" do
    user_input = ["references", "0x12345"]

    memprof = mock("memprof")
    refs = mock("refs")

    connection = mock( "connection" )
    connection.should_receive(:memprof).and_return( memprof )
    connection.should_receive(:references).and_return( refs )

    command = ReferencesCommand.new( connection, user_input )

    refs.should_receive( :find ).with( "refs" => "0x12345" ).and_return( [{"_id" => "0x99999"}] )
    memprof.should_receive( :find ).with( "_id" => "0x99999" ).and_return( [] )


    command.execute!
  end
end

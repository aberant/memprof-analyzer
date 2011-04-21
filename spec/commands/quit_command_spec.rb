require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe QuitCommand do
  it "should exit ruby when executed" do
    user_input = ["quit"]
    db = mock( "db")

    command = QuitCommand.new( db, user_input )

    Kernel.should_receive(:exit)
    command.execute!
  end
end
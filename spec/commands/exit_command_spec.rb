require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe ExitCommand do
  it "should exit ruby when executed" do
    user_input = ["exit"]
    db = mock( "db")

    command = ExitCommand.new( db, user_input )

    Kernel.should_receive(:exit)
    command.execute!
  end
end
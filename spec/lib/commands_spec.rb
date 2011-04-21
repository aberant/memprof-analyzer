require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe Commands do
  before :each do
    class ::TestCommand; end
  end

  after :each do
    Object.send(:remove_const, :TestCommand)
  end

  it "should list a command after it is registered" do
    commands = Commands.new
    commands.register_command( "test_command" )

    commands.to_a.should == ["test"]
  end

  it "should know what command class belongs to what keyword" do
    commands = Commands.new
    commands.register_command( "test_command" )

    commands.find_command( "test" ).should == ::TestCommand
  end

  it "returns the UnknownCommand if it doesn't know the command" do
    commands = Commands.new
    commands.register_command( "test_command" )

    commands.find_command( "bob" ).should == ::UnknownCommand
  end
end

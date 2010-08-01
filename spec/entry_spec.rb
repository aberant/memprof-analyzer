require File.join(File.dirname(__FILE__), "spec_helper")

describe Entry do
  before :each do
    @no_data_class = JSON.parse(<<-EOD
    {
      "_id": "0x1008699",
      "type" : "class",
    	"class" : null,
    	"name" : null,
    	"super" : "null",
    	"super_name" : null,
    	"singleton" : true
  	}
    EOD
    )

    @json_class = JSON.parse(<<-EOD
    {
    	"_id" : "0x1008678",
    	"type" : "class",
    	"class" : "0x103e980",
    	"name" : null,
    	"super" : "0x103e9d0",
    	"super_name" : null,
    	"singleton" : true,
    	"junk": "0x1002343: rb_something",
    	"ivars" : {
    		"__attached__" : "0x10086c8"
    	},
    	"methods" : {
    		"(none)" : "0x10083d0"
    	},
    	"data": [ "0x3dc6ad8", "0x3e71ed8" ],
    	"code" : 3
    }
    EOD
    )
  end

  it "should pull the values from the top level items" do
    entry = Entry.new( @json_class )
    entry.references.should include( "0x103e980", "0x103e9d0" )
  end

  it "should pull the reference values from items that have hashes" do
    entry = Entry.new( @json_class )
    entry.references.should include( "0x10086c8", "0x10083d0" )
  end

  it "should pull the reference values from items that have arrays" do
    entry = Entry.new( @json_class )
    entry.references.should include( "0x3dc6ad8", "0x3e71ed8" )
  end

  it "should cleanly handle entries with no references" do
    entry = Entry.new( @no_data_class )
    entry.references.should == []
  end

  it "should not care about junk in a top level reference" do
    entry = Entry.new( @json_class )
    entry.references.should include( "0x1002343" )
  end
end
require File.join(File.dirname(__FILE__), "spec_helper")

describe ClassEntry do
  before :each do
    @json_class =<<-EOD
    {
    	"_id" : "0x1008678",
    	"type" : "class",
    	"class" : "0x103e980",
    	"name" : null,
    	"super" : "0x103e9d0",
    	"super_name" : null,
    	"singleton" : true,
    	"ivars" : {
    		"__attached__" : "0x10086c8"
    	},
    	"methods" : {
    		"(none)" : "0x10083d0"
    	},
    	"code" : 3
    }
    EOD
  end
  it "should" do
    puts @json_class
  end
end
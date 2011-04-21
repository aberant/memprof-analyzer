require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe String do
  it "is extended to convert a snake cased string to camel case" do
    "camel_cased".camelize.should == "CamelCased"
  end

  it "is extended to convert a camel cased string into a constant" do
    class ::MyTestConstant; end

    "MyTestConstant".constantize.should == ::MyTestConstant
  end
end

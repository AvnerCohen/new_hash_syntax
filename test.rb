require File.expand_path(File.dirname(__FILE__) + "/hash_syntax")

describe "Old syntax with no space in it" do
  it "should add space to verify correct syntax" do
    str="@options={:on=>:create}"

    fix_syntax(str).should eql("@options={on: :create}") 
  end 

  it "should not add space to verify correct syntax as one already present" do
    str="@options={:on=> :create}"
#                       ^
    fix_syntax(str).should eq("@options={on: :create}") 
  end   
  
end
#mdcsv_spec.rb

require_relative "./mdcsv"

describe Mdcsv do
  before :each do
     @md = Mdcsv.new "Testfile1", "Testfile2"
  end
  it "should require an infile and outfile" do
    lambda{Mdcsv.new "one"}.should raise_exception ArgumentError
    lambda{Mdcsv.new "one" "two" "three"}.should raise_exception ArgumentError
  end
  it "should open infile and skip the first line"do
         @md.open_and_skip_line
         @md.infile.lineno.should == 1  
  end

  describe "processing" do
     it "should add a comma to each line after the first word" do
            @md.open_and_skip_line
            @md.process_current_line
            @md.current_line_arr[0].should == 'drop,'
     end

     it "should write each line to the outfile" do
            @md.open_and_skip_line
            @md.process_current_line
            @md.outfile.close
            f = File.open("Testfile2", "r")
            line = f.gets
            line.should == "drop, tables\n" 
     end
     it "should not process the last line in infile" do
        @md = Mdcsv.new("TestFile3", "Testfile2")
        @md.open_and_skip_line
        @md.process_all_lines
        @md.outfile.close
        f = File.open("Testfile2", "r")
        f.count.should == 2
     end

  end
end

class Mdcsv
 attr_accessor :infile , :outfile, :current_line_arr

 def initialize(infile, outfile)
   @infilepath = infile
   @outfilepath = outfile
 end

 def open_and_skip_line
   @infile = File.open(@infilepath)
   @infile.readline
   @outfile = File.open(@outfilepath, "w")
 end

 def process_current_line
   line = @infile.readline
   self.file_process line
 end

 def process_all_lines
     @infile.each do |line|
         unless @infile.eof?
            self.file_process line
         end
     end
     
 end

  def file_process line
   @current_line_arr = line.partition " "
   @current_line_arr[0] += ","
   @outfile.puts @current_line_arr.join
  end  
end

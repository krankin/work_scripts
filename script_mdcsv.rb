
unless ARGV.length == 2
    puts "Usage: mdcsv.rb FileInput FileOutput"
    exit
end

@md = Mdcsv.new(ARGV[0],ARGV[1])
@md.open_and_skip_line
@md.process_all_lines
@md.outfile.close

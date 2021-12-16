=begin  
output file error search by user entered directory 
- files types: log, out, lis
- searches for "ORA-", "SP2", "error" 
=end 
puts "\n\nENTER DIRECTORY TO SCAN:\n\n"
directory_input = gets.chomp


today = Time.new 
fname = "DirectoryScan#{today.year}.#{today.month}.#{today.day}.txt" #scan output file name (ie:)


# following block opens file (will create new or overwrite file if already exists) and writes header to file
result_file = File.open(fname, "w")
result_file.puts "***************************************************************\n\n"
result_file.puts "Directory Scanned: #{directory_input}:\n\n"
result_file.puts "Errors Logs Reviewed on #{today}:\n\n"
result_file.puts "***************************************************************\n\n"

# outputs friendly status message to cmd window
puts "\n\n   ...scanning directory...  \n\n"

=begin  
following block: 
-loops through files in user input directory 
-searches file types out, lis, log for 'ORA-', 'error', 'SP2' 
=end 

Dir.foreach(directory_input) do |filename|
	output_line_to_search = filename.upcase #upper case filename to look for output type (next line)
	if output_line_to_search.end_with?('.OUT') or output_line_to_search.end_with?('.LIS') or output_line_to_search.end_with?('.LOG') or output_line_to_search.end_with?('.ERR')

		# write file information to scan output file
		result_file.puts "------------------------"
		result_file.puts "#{filename}:\n"
		result_file.puts "------------------------\n\n"
  		spool_file = "#{directory_input}/#{filename}"

  		# check each line in file and write line to scan output if it contains: 'ORA-', 'error', 'SP2'
		File.open("#{spool_file}").each do |line|
			if line.include? "ORA\-" or line.include? "error" or line.include? "SP2"
				result_file.puts "#{line}\n\n"
			end 
		end
	end
end


puts "\n\n  DONE like a turkey\n\n"
puts "\n\n      BYYYYYYYYYEeeeeeeeeeeeeeeeee\n\n"
sleep(2)

# close scan output file when finished
result_file.close

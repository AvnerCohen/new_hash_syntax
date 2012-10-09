#!/usr/bin/env ruby

file_name = ARGV[0]

if file_name.isBlank?
	puts "Syntax: new_hash_syntax.rb file_name.rb [CODE].\nCODE - Add to also change code lines and not only comments"
end

new_file = ""
file = File.new(file_name, "r")
while (line = file.gets)
	
	new_file+=line.gsub(/:(\w+) =>/, "$1:")

end
file.close

file = File.new(file_name + "_updated", "w")
file.write(new_file)
file.close

puts "Done. Created " + file_name + "_updated"
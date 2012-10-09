#!/usr/bin/env ruby

file_name = ARGV[0]

if file_name.nil?
	puts "Syntax: new_hash_syntax.rb file_name.rb <FULL>\nFULL - Add to also change code lines and not only comments"
	exit 1
end

full_mode = (ARGV[1].upcase === "FULL")

new_file = ""
file = File.new(file_name, "r")

while (line = file.gets)
	if line.lstrip.start_with?("#") or full_mode
		new_file+= to_new_syntax(line)
	else
		new_file+= line
	end

end
file.close

file = File.new(file_name + "_updated", "w")
file.write(new_file)
file.close

puts "Done. Created " + file_name + "_updated"


def to_new_syntax(line)
	line.gsub(/:(\w+) =>/, '\1:')
end
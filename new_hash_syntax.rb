#!/usr/bin/env ruby

file_name = ARGV[0]

if file_name.nil?
	puts "Usage:\n new_hash_syntax.rb [file_name|folder_name] <FULL>\n\t\tFULL - Add to also change code lines and not only comments"
	exit 1
end

full_mode = (ARGV[1] and ARGV[1].upcase === "FULL")

is_dir = File.directory?(file_name)


def to_new_syntax(line)
	line.gsub(/:(\w+) =>/, '\1:')
end

def convert_file(file_name, full_mode)
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
end

def log_changes(file_name)
	puts "================="
	puts "Created " + file_name + "_updated"
	puts "Compare using:\ndiff #{file_name}_updated #{file_name}"
	puts "Once happy:\nmv #{file_name}_updated #{file_name}"
	puts "================="
end


def process

	if is_dir
		Dir.glob(file_name+"/*/**") {|f|
			unless File.directory?(f)
				convert_file(f, full_mode)
			end
		}
	else

		convert_file(file_name, full_mode)



	end
end
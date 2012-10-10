#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + "/color_helper.rb")

target = ARGV[0]

if target.nil?
	puts red("Usage:") + "\n new_hash_syntax.rb [file_name|folder_name] " + green("FULL") + "\n\t\t"+ green("FULL") +" - Add to also change code lines and not only comments"
	exit 1
end

full_mode = (ARGV[1] and ARGV[1].upcase === "FULL")

is_dir = File.directory?(target)


@postfix = "_updated"


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

	file = File.new(file_name + @postfix, "w")
	file.write(new_file)
	file.close
end

def log_changes(file_name)
	puts "Compare using:\n\t\t"+ green("diff #{file_name}#{@postfix} #{file_name}")
	puts "To Overwrite:\n\t\t"+ green("mv #{file_name}#{@postfix} #{file_name}\n")
end


def process(is_dir, target, full_mode)

puts target
	if is_dir
		Dir.glob(target+"/**/**") {|f|
			if File.file?(f) and f.match(/#{@postfix}$/).nil?
				convert_file(f, full_mode)
				log_changes(f)
			end
		}
	else
		convert_file(target, full_mode)
		log_changes(file_name)
	end
end


## Activate

process(is_dir, target, full_mode)


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
	line.gsub(/:(\w+)(\s*)=>/, '\1:')
end

def convert_file(file_name, full_mode)
	new_file = ""
	file = File.new(file_name, "r")

	changes_made=false #keep track if this files even needs saving or not

	while (line = file.gets)
		updated_line=to_new_syntax(line)

		if line_should_be_editable(line, full_mode, file_name)
			new_file+=updated_line
			changes_made = changes_made || (updated_line != line)
		else
			new_file+=line
		end
	end
	file.close

	save_file(file_name, new_file) if changes_made # execute new save only if changes made to original
end

def line_should_be_editable(line, full_mode, file_name)
	if file_name.match(/\.rb$/).nil? or full_mode # Case of no *.rb file, not code. if full_mode - doesn't matter
		return true
	end

	if line.lstrip.start_with?("#")
		return true
	end

	return false
end


def save_file(orig_file_name, content)

	new_file_name = orig_file_name + @postfix

	file = File.new(new_file_name, "w")
	file.write(content)
	file.close

	log_changes(orig_file_name)
end



def log_changes(file_name)

	new_file_name = file_name + @postfix

	puts "Compare using:\n\t\t"+ green("diff #{new_file_name} #{file_name}")
	puts "To Overwrite:\n\t\t"+ green("mv #{new_file_name} #{file_name}\n")
end


def process(is_dir, target, full_mode)

	if is_dir
		Dir.glob(target+"/**/**[*.rb|*.|*.md|*.rdoc]") {|f|
			if File.file?(f) and f.match(/#{@postfix}$/).nil?
				convert_file(f, full_mode)
			end
		}
	else
		convert_file(target, full_mode)
	end
end


## Activate

process(is_dir, target, full_mode)


#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + "/color_helper.rb")
require File.expand_path(File.dirname(__FILE__) + "/hash_syntax.rb")


target = ARGV[0]

if target.nil?
	puts red("Usage:") + "\n new_hash_syntax.rb [file_name|folder_name] " + green("FULL") + "\n\t\t"+ green("FULL") +" - Add to also change code lines and not only comments"
	exit 1
end

full_mode = (ARGV[1] and ARGV[1].upcase === "FULL")

is_dir = File.directory?(target)


@postfix = "_updated"


## Run
process(is_dir, target, full_mode)


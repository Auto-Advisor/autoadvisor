#!/usr/bin/env ruby



catalog_lines = StringList.new

aFile = File.new("course_catalog.txt", "r")
aFile.each_line("\n") do |line|
    if not is_banned line
        catalog_lines.append(line)
    end
end

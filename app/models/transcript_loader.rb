#!/usr/bin/env ruby

class StringList
    def initialize
        @strings = Array.new
    end
    
    def [](key)
        if key.kind_of?(Integer)
            @strings[key]
        else
            put "nope"
        end
    end

    def append(aString)
        @strings.push(aString)
        self
    end

    def length
        @strings.length
    end

end

lines = StringList.new

aFile = File.new("transcript.txt", "r")
aFile.each_line("\n") do |line|
    lines.append(line)
end

u = user.new
u.apply_transcript(lines)



#!/usr/bin/env ruby



#check if the line shouldn't be read
def is_banned(line)
    state = false
    banned = [/^page/, /^\f/, /^University of Massachusetts/, /^Class Nbr/, /^  Cmp/, /^Section/, /^Cls type/, /^Meeting Time/ , /^Bldg & Room/, /^Grading/, /^as of/, /^Schedule of/]
    banned.each do |b|
        if b.match(line) or line.eql?"\n" or line.eql?" \n"
            state = true
        end
    end
    return state
end

def write_clean_catalog(to_write)
    outFile = File.open("cleaned_course_catalog.txt", "w")
    for i in 0...to_write.length
            outFile.puts to_write[i]
    end
end

class CourseInformation
    attr_accessor :id, :department, :number, :letter, :days, :start_time, :end_time, :associated, :section, :primary, :instructor, :name, :gened, :mincredit, :maxcredit

    def initialize
        @id = ""
        @department = ""
        @number  = ""
        @letter = ""
        @days =""
        @start_time = ""
        @end_time=""
        @associated = ""
        @section = ""
        @primary = "false"
        @instructor = ""
        @name = ""
        @gened = ""
        @mincredit = ""
        @maxcredit = ""
    end

    def write 
        @start_time.strip
        @outFile.puts "\"" + @id + "\",\"" + @department + "\",\"" + @number + "\",\"" + @days + "\",\"" + @start_time + "\",\"" + @end_time + "\",\"" + @associated + "\",\"" + @section + "\",\"" + @primary + "\",\"" + @instructor + "\",\"" + @name + "\",\"" + @gened + "\",\"" + @mincredit + "\",\"" + @maxcredit + "\"\n"
        @id = ""
        @days = ""
        @start_time = ""
        @end_time=""
        @associated = ""
        @section = ""
        @primary = "false"
        @instructor = ""
    end

    def use(afile)
        @outFile = afile
    end

end

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

catalog_lines = StringList.new

aFile = File.new("course_catalog.txt", "r")
aFile.each_line("\n") do |line|
    if not is_banned line
        catalog_lines.append(line)
    end
end

course = CourseInformation.new
i = 0
#set this flag so that the same course isn't written multiple times
ignore_line = false
#indicates that is is possible for the current line to be a day
day_possible = false
#number of lines since last course number was seen
course_num_seen = 2000
#number of lines since last spire id was seen
course_id_seen = 2000
outFile = File.open("courses.csv", "w")
outFile.puts "SpireID,Dept,Number,Days,StartTime,EndTime,Associated,SectionNum,PrimaryClass,Instructor,CourseName,GenEd,MinCredit,MaxCredit\n"
course.use(outFile)
while i < catalog_lines.length
    line_processed = false
    #Case that current line is department indicator
    if /^Min - Max Units/.match(catalog_lines[i])
        i = i+1
        if not course.department == catalog_lines[i].strip
            course.write
            ignore_line = true
            course.department = catalog_lines[i].strip
        end
        line_processed = true
    end
    #Case that current line is course number
    if /^[A-Z\-&]{3,8}\s+[HG\d]\d{2,3}[A-Z]{,2}\n/.match(catalog_lines[i]) and not /^SOM/.match(catalog_lines[i]) and not /^NAH/.match(catalog_lines[i]) and not /^JFK/.match(catalog_lines[i])
        #if we are at the start of a new course listing
        if not course.number == catalog_lines[i].strip
            #don't write out the current course if it's already been written out
            if not ignore_line
                course.write
                ignore_line = true
            end
            course.name = ""
            course.number = catalog_lines[i].strip
            course.gened = ""
        end
        course_num_seen = 0
        line_processed = true
    end
    #checks if gened line
    if  /^GenEd/.match(catalog_lines[i])
        #gened discovery needs to occur right after course name discovery, since gened indication for a course can occur after the first spire id is written
        #puts catalog_lines[i].partition("  ")[2]
        course.gened = catalog_lines[i].partition("  ")[2].strip
        #puts course.gened
        line_processed = true
    end
    #Case that current line is SPIRE ID
    if /^\d{5}$/.match(catalog_lines[i].strip)
        #any time we see a new spire ID, we need to write out the current course info and flush non-recurring info
        if not course.id == catalog_lines[i].strip and ignore_line == false
            course.write
        end
        course.id = catalog_lines[i].strip
        ignore_line = false
        line_processed = true
        course_id_seen = 0
    end
    #checks if line is section (guards against selecting a day as a section)
    if /^\w{,2}\d{1,2}$/.match(catalog_lines[i].strip) or /^[A-EG-LN-V]$/.match(catalog_lines[i].strip)
        #if the previous line was a repeated course number, the write out the current course information
        if course_num_seen < 2 and ignore_line == false
            course.write
            ignore_line = true
        end
        #if a new section number is seen when the current section number isn't empty, then write out the current course information
        if not course.section == ""
            if /^[MWF]$/.match(course.section)
            course.days = course.section
            course.section = catalog_lines[i].strip
            else
            course.write
            ignore_line = true
            end
        end
        course.section = catalog_lines[i].strip
        line_processed = true
    end
    #checks if line is day
    if /^[MWF]{1,3}$/.match(catalog_lines[i].strip) or /^(M|TU|W|TH|F|SA|SU){1,5}$/.match(catalog_lines[i].strip)
        #if the section hasn't been seen yet, assume this is the section
        if course.section == "" and not /^(MW)|(TU)|(TH)|(SA)|(SU)$/.match(catalog_lines[i].strip)
            course.section = catalog_lines[i].strip
        else
            course.days = catalog_lines[i].strip
        end
    end
    #checks if line is time
    if /^\d{0,2}:\d\d:\d\d[A-Z][A-Z]/.match(catalog_lines[i].strip)
        course.start_time = catalog_lines[i].strip.scan(/\d{1,2}:\d\d:\d\d[A-Z][A-Z]/)[0]
        if catalog_lines[i].strip.scan(/\d{1,2}:\d\d:\d\d[A-Z][A-Z]/)[1].nil?
            keep_searching = true
            while(keep_searching)
                i = i + 1
                if /^\d{1,2}:\d\d:\d\d[A-Z][A-Z]/.match(catalog_lines[i].strip)
                    course.end_time = catalog_lines[i].strip.scan(/\d{1,2}:\d\d:\d\d[A-Z][A-Z]/)[0]
                    keep_searching = false
                end
            end
        else
            course.end_time = catalog_lines[i].strip.scan(/\d{1,2}:\d\d:\d\d[A-Z][A-Z]/)[1]
        end
        line_processed = true
    end
    #check if line is credit count
    if /\d{0,2}\.\d\d-\d{0,2}\.\d\d/.match(catalog_lines[i].strip)
        course.mincredit = /(?<min>\d{0,2}\.\d\d)-(?<max>\d{0,2}\.\d\d)/.match(catalog_lines[i].strip)[:min]
        course.maxcredit = /(?<min>\d{0,2}\.\d\d)-(?<max>\d{0,2}\.\d\d)/.match(catalog_lines[i].strip)[:max]
        line_processed = true
    end
    #check if primary course
    if catalog_lines[i].strip == "Enrollment"
        course.primary = "true"
        line_processed = true
    else
        if catalog_lines[i].strip == "Related"
            course.primary = "false"
            line_processed = true
        end
    end
    #checks if line is course name
    if course.name.length == 0 and catalog_lines[i].strip.length > 1 and line_processed == false and (course_id_seen < 3 or course_num_seen < 2)
        course.name = catalog_lines[i].strip
    end
    i = i+1
    course_num_seen = course_num_seen + 1
    course_id_seen = course_id_seen + 1
end
course.write

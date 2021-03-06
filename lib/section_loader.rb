require 'csv'
require 'date'

class CSVFormatError < Exception
end

def parse_time str
  match = /(\d+):(\d+):00(AM|PM)/.match(str.strip)
  return 0 if match.nil?
  hours = match[1].to_i
  mins = match[2].to_i
  meridian = match[3]
  hours += 12 if meridian == 'PM' && hours < 12
  return hours * 60 + mins
end

def load_sections file, logger
  rows = CSV.read(file)
  rows.shift # pop off the header
  #SpireID, Dept, Number, Days, StartTime, EndTime, Associated, SectionNum, PrimaryClass, Instructor, CourseName, GenEd, MinCredit, MaxCredit

  rows.each_index do |idx|
    line = idx + 2 # we popped off header.
    row = rows[idx]
    begin
      next if row[0].blank?
      raise CSVFormatError, "Bad number of entries in CSV row #{line}." if row.length != 14
      class_num_info = row[2].split
      major_code = class_num_info[0]
      num_string = class_num_info[1] or puts row[2].to_s
      num = num_string[0..2]
      class_string = major_code + num_string
      name = row[10]

      major = Major.where('code = ?', major_code).first
      if major.nil?
        major = Major.new
        major.degree = nil
        major.dept = row[1].strip
        major.name = ""
        major.code = major_code
        major.save
      end

      # :dept, :desc, :name, :number, :sections, :string
      course = Course.joins(:major).where('courses.number = ? AND majors.code = ?', num, major_code).first
      if course.nil?
        course = Course.new
        course.major = major
        course.desc = nil
        course.name = name
        course.number = num
        course.string = class_string
        course.save
      end

      section_number = row[7].strip

      section = Section.new
      section.course = course
      section.credit_max = row[13].to_f.to_i || 0
      section.credit_min = row[12].to_f.to_i || 0
      section.days = row[3].strip.sub(/TU/, "T").sub(/TH/, "R")
      section.instructor = row[9].strip
      section.min_start = row[4].blank? ? 0 : parse_time(row[4])
      section.min_end = row[5].blank? ? 0 : parse_time(row[5])
      section.section_number = section_number
      section.spire_id = row[0]
      section.ty = case section_number
        when /D\d/
          "DIS"
        when /L\d/
          "LAB"
        when /S\d/
          "SEM"
        else
          "LEC"
      end
      section.save
    rescue CSVFormatError => e
      logger.debug "Encountered error while processing csv row #{line}:\n#{e.inspect}\n#{e.backtrace.join('\n')}\n"
    end
  end
end
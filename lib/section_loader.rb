require 'csv'

def load_sections file, logger
  rows = CSV.read(file)
  rows.shift # pop off the header
  #SpireID, Dept, Number, StartTime, EndTime, Associated, SectionNum, PrimaryClass, Instructor, CourseName
  rows.each_index do |idx|
    line = idx + 2
    row = rows[idx]
    begin
      if row.length != 10
        raise "Bad number of entries in CSV row #{line}."
        next
      end
      class_num_info = row[2].split
      dept = class_num_info[0]
      num_string = class_num_info[1]
      num = num_string[0..2]
      class_string = dept + num_string
      puts class_string

      section = Section.new
      section.spire_id = row[0]
      section.dept = dept
      section.class_number = num
      section.class_string = class_string
      section.section_number = row[6]
      if row[7] # primary
        section.type = 'LEC' # could also be sem
      else
        section.type = 'unknown'
      end
      section.instructor = row[8]
      section.name = row[9]
      section.save
    rescue Exception => e
      logger.debug "Encountered error while processing csv row #{line}:\n#{e.inspect}\n#{e.backtrace.join '\n'}"
    end
  end
end
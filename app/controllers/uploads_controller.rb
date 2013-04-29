class UploadsController < ApplicationController

  #Upload a transcirpt. if there is a file to upload temporaraly save it
  #in "public/uploadedTranscript", then delete it after parsing. if no 
  #file to upload, stay on same page.
  def upload_credits
    if (!params[:file].blank?)
        transcript = params[:file].read
        current_user.apply_transcript(transcript) if !current_user.nil?
        redirect_to transcript_path
      else
        #file field was blank
        redirect_to transcript_path
      end
  end

  #Upload an individual course then redirect back to the transcript
  #page. New course should be visible. Only uploads if all 4 fields 
  #are filled in.
  def add_credit
    year = params[:year]
    grade = params[:grade].upcase
    units_str = params[:units]
    course_string = params[:course_string].upcase

    if [year, grade, units_str, course_string].all? {|v| v.blank?}
      redirect_to transcript_path and return
    end

    if /^\d+$/.match(year).nil?
      redirect_to transcript_path, :alert => "Year entered is not a valid year, please use YYYY." and return
    end

    if Credit.points_for_letter(grade).nil?
      redirect_to transcript_path, :alert => "\"#{grade}\" is not a valid grade." and return
    end

    if /^\d+(?:\.\d+)?$/.match(units_str).nil?
      redirect_to transcript_path, :alert => "Units entered is not a valid number, please enter a positive number." and return 
    end
    units = BigDecimal.new(units_str)

    if units.nil? || units < 0
      redirect_to transcript_path, :alert => "Units entered is a negative number, please enter a positive number." and return
    end

    course = Course.find_or_create_dummy(course_string)
    credit = Credit.from_course(course, year, units, grade)
    current_user.transcript << credit
    if course.hidden
      redirect_to transcript_path, :flash => { :warning => "Credit \"#{course_string}\" has been successfully added to your transcript even though the course code could not be found." } and return
    end
    redirect_to transcript_path, :flash => { :success => "Credit \"#{course_string}\" has been successfully added to your transcript." } and return
  end

  #Deletes the selected course information from the users records based
  #on couse code and year.
  def delete_credit
    credit = Credit.find(params[:id]) or redirect_to transcript_path
    credit.destroy
    redirect_to transcript_path
  end

end

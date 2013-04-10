class UploadsController < ApplicationController

  #Upload a transcirpt. if there is a file to upload temporaraly save it
  #in "public/uploadedTranscript", then delete it after parsing. if no 
  #file to upload, stay on same page.
  def upload_credits
    if (!params[:file].blank?)
      transcriptFile =  params[:file].original_filename
        directory = "public/uploadedTranscript"
        path = File.join(directory, transcriptFile)
        File.open(path, "wb") { |f| f.write(params[:file].read)}
        #system(path/to/parser #{"public/uploadedTranscript/"+transcriptFile})
        #File.delete("public/uploadedTranscript/"+transcriptFile)
        redirect_to :controller => 'users', :action => 'transcript'
      else
        #file field was blank
        redirect_to :controller => 'users', :action => 'transcript'
      end
  end

  #Upload an individual course then redirect back to the transcript
  #page. New course should be visible. Only uploads if all 4 fields 
  #are filled in.
  def add_credit
    if (!params[:year].blank?)&&(!params[:course_string].blank?)&&(!params[:grade].blank?)&&(!params[:units].blank?)
      course = Course.where("string = ?", params[:course_string]).first
      if course.nil?
        # HANDLE ERROR
      else
        current_user.transcript << Credit.from_course(course, params[:year], params[:units], params[:grade])
      end
      redirect_to :controller => 'users', :action => 'transcript'
    else
      #at least 1 field was left blank
      redirect_to :controller => 'users', :action => 'transcript'
    end
  end

  #Deletes the selected course information from the users records based
  #on couse code and year.
  def delete_credit
    credit = Credit.find(params[:id]) or redirect_to :controller => 'users', :action => 'transcript'
    credit.destroy
    redirect_to :controller=>'users', :action=> 'transcript'
  end

end

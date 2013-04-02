class UploadsController < ApplicationController

	#Upload a transcirpt. if there is a file to upload temporaraly save it
	#in "public/uploadedTranscript", then delete it after parsing. if no 
	#file to upload, stay on same page.
	def upload_transcript
		if (!params[:file].blank?)
			transcriptFile =  params[:file].original_filename
    		directory = "public/uploadedTranscript"
    		path = File.join(directory, transcriptFile)
    		File.open(path, "wb") { |f| f.write(params[:file].read)}
    		#system(path/to/parser #{"public/uploadedTranscript/"+transcriptFile})
    		#File.delete("public/uploadedTranscript/"+transcriptFile)
    		redirect_to :action => 'transcript', :controller => 'users'
    	else
    		#file field was blank
    		redirect_to :action => 'transcript', :controller => 'users'
    	end
	end

	#Upload an individual course then redirect back to the transcript
	#page. New course should be visible. Only uploads if all 4 fields 
	#are filled in.
	def upload_course
		if (!params[:year].blank?)&&(!params[:courseCode].blank?)&&(!params[:grade].blank?)
      section = Section.where("class_string == ?", params[:courseCode]).first
			current_user.transcript << Credit.from_section(section, params[:year], params[:grade])# if !section.nil?
			redirect_to :controller => 'users', :action => 'transcript'
		else
			#at least 1 field was left blank
			redirect_to :controller => 'users', :action => 'transcript'
		end
	end

	#Deletes the selected course information from the users records based
	#on couse code and year.
	def delete
		obj = current_user.transcript.find(:all, :conditions => 
				["course_code == '?' AND year == '", params[:courseCode], params[:year]])
		obj.each {|o| o.destroy}
		redirect_to :action=> 'transcript', :controller=>'users'
	end

end

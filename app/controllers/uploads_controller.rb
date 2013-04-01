class UploadsController < ApplicationController

	#Upload a transcirpt. if there is a file to upload temporaraly save it
	#in "public/uploadedTranscript", then delete it after parsing. if no 
	#file stay on same page.
	
	#!!!!!!!!YOU NEED TO CREATE public/uploadTranscript FOR THIS TO WORK!!!!!!!
	
	def upload_transcript
		usernow = User.find(session[:'warden.user.user.key'][1][0])
		if (!params[:file].blank?)
			transcriptFile =  params[:file].original_filename
    		directory = "public/uploadedTranscript"
    		path = File.join(directory, transcriptFile)
    		File.open(path, "wb") { |f| f.write(params[:file].read)}
    		#system(path/to/parser #{"public/uploadedTranscript/"+transcriptFile})
    		#File.delete("public/uploadedTranscript/"+transcriptFile)
    		redirect_to :action => 'transcript', :controller => 'pages'
    	else
    		#file field was blank
    		redirect_to :action => 'transcript', :controller => 'pages'
    	end
	end

	#Upload an individual course then redirect back to the transcript
	#page. New course should be visible. Only uploads if all 4 fields 
	#are filled in.
	def upload_course
		if (!params[:year].blank?)&&(!params[:courseName].blank?)&&(!params[:courseCode].blank?)&&(!params[:grade].blank?)
			usernow = User.find(session[:'warden.user.user.key'][1][0])
			usernow.past_courses << PastCourse.new(
					:year => params[:year], 
					:course_name => params[:courseName], 
					:course_code => params[:courseCode], 
					:grade => params[:grade])
			redirect_to :action =>'transcript', :controller => 'pages'
		else
			#at least 1 field was left blank 
			redirect_to :action =>'transcript', :controller => 'pages'
		end
	end

	#Deletes the selected course information from the users records based
	#on couse code and year.
	def delete
		usernow = User.find(session[:'warden.user.user.key'][1][0])
		obj = usernow.past_courses.find(:all, :conditions => 
				["past_courses.course_code IN (?) AND past_courses.year IN(?)",
				params[:courseCode], params[:year]])
		obj.each {|o| o.destroy}
		redirect_to :action=> 'transcript',:controller=>'pages'
	end

end

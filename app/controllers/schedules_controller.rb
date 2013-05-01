require 'json'

class SchedulesController < ApplicationController
  def schedule
    @user = current_user
    redirect_to advisor_path, :notice => "You don't have any schedules yet. This is where AutoAdvisor recommends classes for you." and return if @user.schedules.empty?
  end

  def all_classes
  end

  def filter_class
  end

  def get_schedules(constraints)
    if constraints[:major] != "ACCOUNTG"
      return [];
    else
      schedules = [[
        {
          name: "CMPSCI320",
          day: "TuTh",
          beg_time: "1601",
          end_time: "1715",
          discussion: {
            name: "CMPSCI320-Dis",
            day: "We",
            beg_time: "1430",
            end_time: "1520"
          }
        }, {
          name: "CMPSCI326",
          day: "MoWeFr",
          beg_time: "1115",
          end_time: "1205"
        }, {
          name: "CMPSCI383",
          day: "TuTh",
          beg_time: "1115",
          end_time: "1230",
          laboratory: {
            name: "CMPSCI383Lab",
            day: "Once Upon a Time",
            beg_time: "1115",
            end_time: "1205"
          }
        }, {
          name: "CMPSCIXXX",
          day: "MWF",
          beg_time: "1115",
          end_time: "1205",
          discussion: {
            name: "DIS",
            day: "W",
            beg_time: "1115",
            end_time: "1205",
          },
          laboratory: {
            name: "LAB",
            day: "F",
            beg_time: "1115",
            end_time: "1205"
          }
        }
        ], [
          {
            name: "CMPSCI453",
            day: "HiHi",
            beg_time: "1115",
            end_time: "1205"
          }, {
            name: "ECON103",
            day: "Mo",
            beg_time: "1115",
            end_time: "1205",
            discussion: {
              name: "ECON103-Dis05",
              day: "Fr",
              beg_time: "1115",
              end_time: "1205"
            }
          }
        ]
      ]
    end
    return schedules
  end

  def recommend
    constraints = params
  	@schedules = get_schedules(constraints)
  	respond_to do |format|
  	  format.json { render :json => @schedules }
  	  format.html
  	end
  end

  def getSearchResult(keys)
    temp = Section.get_new_schedule(1)
    sections = [{
      course: "CMPSCI320",
      name: "Software Engineering",
      details: "Details",
      sections: [{
        number: "01-Lec",
        id: "31748",
        day: "TuTh",
        time: "11:15AM-12:30PM",
        room: "MorrillSci Ctr",
        instructor: "Yuriy"
      }, {
        number: "02-Lec",
        id: "31758",
        day: "MoWeFr",
        time: "TBA",
        room: "TBA",
        instructor: "YBA"
      }]
    }, {
      course: "ECON103",
      name: "Microeconomics",
      details: "Details 2",
      sections: [{
        number: "Lec",
        id: "10203",
        day: "Mo",
        time: "8:00AM-8:50AM",
        room: "Mahar",
        instructor: "TBA"
      }]
    }]
    return temp
  end

  def search
    keys = params[:schedule]
    @result = getSearchResult(keys)
    respond_to do |format|
      format.json {render :json => @result }
    end
  end

  def recommend_schedule
    @user = current_user
    if request.get?
      render "recommend_schedule"
    else
      redirect_to schedule_recommend_path
    end
  end

  #given a set of json constraints, generates a json version of a schedule which meets
  #those constraints
  def generate_json_schedule
    json = get_json || []
    sections = generate_schedule(Section.sections_for_constraints(json))
    render :json => sections
  end
  
  #given a set of parameters, generates a schedule which meets those parameters
  #where the parameters include
  #:query is the set of all sections which meet the query specifications
  #:specified_courses is all the courses which the user specifically requested
  #:specified_sections is all the sections which the user specifically requested
  #:number_restriction is a flag indicating that there is a restriction on the number of
  #             courses
  #:credit_restriction is a flag indicating that there is a restriction on the number of
  #             courses
  def generate_schedule(opts)
    query = opts[:query]
    courses = opts[:specified_courses]
    sections = opts[:specified_sections]
    number_restriction = opts[:number_restriction]
    credit_restriction = opts[:credit_restriction]
    num_lower_courses = opts[:num_lower_courses]
    num_upper_courses = opts[:num_upper_courses]
    num_lower_credits = opts[:num_lower_credits]
    num_upper_credits = opts[:num_upper_credits]
    major = opts[:major]
    major_course_restriction = opts[:major_course_restriction]
    min_maj_courses = opts[:min_maj_courses]
    max_maj_courses = opts[:max_maj_courses]
    maj_courses_so_far = 0
    credits_so_far = 0
    courses_so_far = 0
    sched = []
    puts sections.nil?
    #if there are no sections that meet the constraints, then return any empty array
    if query.empty?
        return sched
    end

    #if we have just a number of credits or courses restriction, then shut off the other restriction's defaults
    if number_restriction and not credit_restriction
        num_lower_credits = 0
        num_upper_credits = 100
    end
    if credit_restriction and not number_restriction
        num_lower_courses = 0
        num_upper_courses = 100
    end

    #loop until we've built a schedule from the set of available sections which meets the minimum number
    #of credits and courses
    targets_unmet = true   
    while(targets_unmet)
      #if there are no specified courses, use one from the list of all eligable coures
      #sections = []
      #courses = []
      if not sections.empty?
        sect = sections.pop
      elsif not courses.empty?
        sect = courses.pop
      else
        #this will be where we ensure that we aren't picking any *96,*98,*99 unless ordered to
        invalid_section = true
        while(invalid_section)
            sect = query.all.sample
            puts sect.number
            if !(sect.number.modulo(100) == 96 or sect.number.modulo(100) == 98 or sect.number.modulo(100) == 99)
                invalid_section = false
            end
        end
      end
      next unless sect.ty == 'LEC' #if this thing isn't a lecture, skip through and begin the loop again
      matching_courses = sched.select {|s| (s.major.code == sect.major.code and s.number == sect.number)}
      next unless matching_courses.empty?
      #ensure that we aren't violating a restriction on the number of major courses by adding this class
      abort = false
      if major_course_restriction
        if (maj_courses_so_far < min_maj_courses and sect.major.code != major)
            abort = true
        end
        if (maj_courses_so_far >= min_maj_courses and sect.major.code == major)
            abort = true
        end
        if sect.major.code == major
            maj_courses_so_far += 1
        end
      end
      next unless not abort
      #only add this section if it doesn't cause the number of credits to go over the maximum
      #this is setup so that we assume each section provides its minimum number of credits
      cred_incr = sect.credit_min
      if (credits_so_far + cred_incr) > num_upper_credits
        abort = true
      end
      next unless not abort
      
      #check for time and date overlaps with already selected schedules
      for sched_section in sched
        if (sched_section.start_s <= sect.start_s and sect.start_s <= sched_section.end_s) or (sched_section.start_s <= sect.start_s and sect.end_s <= sched_section.end_s)
            for day in sched_section.days.chars
                if sect.days.include? day
                    abort = true
                end
            end
        end
      end
      next unless not abort

      sched.append(sect)
      #we are currently randomly adding a section/lab if those things exist
      #poss represents the set of all sections which have the same major code and course number as the
      #current section of interest
      poss = query.where("majors.code = ? AND courses.number = ?", sect.major.code, sect.course.number)
      disc = []
      labs = []
      # sched.append(poss.sample)
      #this loop seeks to find any discussions and labs associated with the current section and
      #add those to their respective list
      for cur in poss
          next unless cur.ty != 'LEC'
          if cur.section_number.include?('d')
              disc.append(cur)
          end
          if cur.section_number.include?('l')
              labs.append(cur)
          end
      end
      if (disc.length > 0) 
          sched.append(disc.sample) 
      end
      if (labs.length > 0) 
          sched.append(labs.sample) 
      end
      credits_so_far += cred_incr
      courses_so_far += 1
      #end
      targets_unmet = (credits_so_far < num_lower_credits or courses_so_far < num_lower_courses)
    end  
      #
      # targets_so_far+=1
    # sched.add()
    # end
    # return sect
    sched.compact
  end

  def render_error(msg)
    render :json => {'success' => false, 'message' => msg}
  end

  def render_success(msg, schedule=nil, schedules=nil)
    render :json => {'success' => true, 'message' => msg, 'schedule' => schedule.as_json, 'schedules' => schedules.as_json}
  end

  # POST
  # takes: {'name': string, 'sections': [spire_id]}
  # returns: application/json { 'success': boolean, 'message': string, 'schedule': schedul_hash }
  def create
    render_error "No currently logged in user, can't create schedule." and return if !signed_in?

    payload = get_json
    render_error "Empty or nil payload." and return if payload.nil?
    render_error "No 'name' association is given in request." and return if !payload.include? 'name'
    render_error "No 'sections' association is given in request" and return if !payload.include? 'sections'

    name = payload['name']
    spire_ids = payload['sections']

    sections = spire_ids.map do |spire_id|
      section = Section.where('spire_id = ?', spire_id).first
      render_error "Could not find section with spire id '#{spire_id}'." and return if section.nil?
      section
    end

    schedule = Schedule.new
    schedule.name = name
    schedule.sections = sections
    schedule.save
    current_user.schedules << schedule

    render_success "Created schedule \"#{name}\".", schedule
  end

  # See models/section.rb for a description of the section format.
  # See models/schedule.rb for a description of the schedule format.

  # POST
  # takes: {'id': id, 'name': string, 'sections': [spire_id]}
  # returns: application/json { 'success': boolean, 'message': string, 'schedule': schedule_hash }
  def update
    render_error "No currently logged in user, can't create schedule." and return if !signed_in?

    payload = get_json
    render_error "Empty request." and return if payload.nil?
    render_error "No 'name' association is given in request." and return if !payload.include? 'name'
    render_error "No 'sections' association is given in request" and return if !payload.include? 'sections'
    render_error "No 'id' association is given in request" and return if !payload.include? 'id'

    name = payload['name']
    spire_ids = payload['sections']
    id = payload['id']

    schedule = Schedule.find(id)
    render_error "No schedule found for schedule \##{id}" and return if schedule.nil?

    sections = spire_ids.map do |spire_id|
      section = Section.where('spire_id = ?', spire_id).first
      render_error "Could not find section with spire id '#{spire_id}'." and return if section.nil?
      section
    end

    schedule.name = name
    schedule.sections = sections
    schedule.save
    current_user.schedules << schedule

    render_success "Updated schedule \"#{name}\".", schedule
  end

  # POST
  # takes: {'id': id }
  # returns: application/json { 'success': boolean, 'message': string }
  def destroy
    render_error "No currently logged in user, can't create schedule." and return if !signed_in?

    payload = get_json
    render_error "Empty request." and return if payload.nil?
    render_error "No 'id' association is given in request" and return if !payload.include? 'id'
    if Schedule.destroy(payload['id'])
      render_success "Schedule successfully destroyed."
    else
      render_error "Could not delete requested schedule."
    end
  end

  # POST
  # takes: {'id': id}
  # returns: application/json { 'success': boolean, 'message': string, 'schedule': {'name': string, sections: [sections], primary: bool}}
  def get
    payload = get_json
    render_error "Empty request." and return if payload.nil?
    render_error "No 'id' association is given in request" and return if !payload.include? 'id'
    schedule = Schedule.find(payload["id"])
    if schedule.nil?
      render_error "Unable to get schedule with id #{payload['id']}"
    else
      render_success "", schedule
    end
  end

  # POST, GET
  # takes: authentication.
  # returns: application/json { 'success': boolean, 'message': string, 'schedules': [schedule]}
  def list
    render_error "No currently logged in user, can't list users' schedules." and return if !signed_in?
    render_success "Successfully fetched list.", nil, (current_user.schedules.order("name DESC").all || [])
  end

  # parses json from body if post.
  def get_json
    return nil unless request.post?
    ActiveSupport::JSON.decode(request.raw_post)
  end
end

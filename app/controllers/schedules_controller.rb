require 'json'

class SchedulesController < ApplicationController
  def schedule
    @rec = Section.get_new_schedule(10)
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
    return schedules;
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
    if request.get?
      render "recommend_schedule"
    else
      redirect_to schedule_recommend_path
    end
  end

  def generate_json_schedule
    json = get_json || []
    sections = generate_schedule(Section.sections_for_constraints(json))
    render :json => sections
  end

  def generate_schedule(opts)
    query = opts[:query]
    courses = opts[:specified_courses]
    credits = opts[:specified_credits]
    target_type = opts[:target_type]
    lower = opts[:lower]
    upper = opts[:upper]
    targets_so_far = 0
    lower = 4
    sched = []
   
    while(targets_so_far < lower)
      sect = query.all.sample
      next unless sect.ty == 'LEC' 
      poss = query.where("majors.code = ? AND courses.number = ?", sect.major.code, sect.course.number)
      disc = []
      labs = []
      # sched.append(poss.sample)
      for cur in poss
        next unless cur.ty != 'LEC'
        if cur.section_number.include?('d')
          disc.append(cur)
        end
        if :section_number.include?('l')
          labs.append(cur)
        end
      end
      
      
      incr = (target_type == :credits ? sect.credits : 1)
      sched.append(sect)
 
      if (disc.length > 0) 
        sched.append(disc.sample) 
      end
       if (labs.length > 0) 
        sched.append(labs.sample) 
      end
      targets_so_far += incr
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

  def render_success(msg)
    render :json => {'success' => true, 'message' => msg}
  end

  # POST
  # takes: {'name': string, 'sections': [spire_id]}
  # returns: application/json { 'success': boolean, 'message': string }
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

    render_success "Created schedule \"#{name}\"."
  end

  # POST
  # takes: {'id': id, 'update': <format for create>}
  # returns: application/json { 'success': boolean, 'message': string}
  def update
    render_error "No currently logged in user, can't create schedule." and return if !signed_in?
  end

  # POST
  # takes: {'id': id }
  # returns: application/json { 'success': boolean, 'message': string}
  def destroy
    render_error "No currently logged in user, can't create schedule." and return if !signed_in?
  end

  # POST
  # takes: {'id': id}
  # returns: application/json { 'success': boolean, 'message': string, 'schedule': {'name': string, sections: [sections], primary: bool}}
  def get
  end

  # parses json from body if post.
  def get_json
    return nil unless request.post?
    ActiveSupport::JSON.decode(request.raw_post)
  end
end

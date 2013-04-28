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
      redirect_to :controller => 'schedules', :action => 'recommend_schedule'
    end
  end

  def generate_json_schedule
    redirect_to :controller => 'schedules', :action => 'recommend_schedule' unless request.post?
    json_string = request.raw_post || ""
    json = ActiveSupport::JSON.decode(json_string) || []
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
    query.all.sample(4)
  end
end

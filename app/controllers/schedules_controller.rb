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
    elsif request.post?
      json_string = request.raw_post || ""
      json = ActiveSupport::JSON.decode(json_string) || []
      sections = Section.sections_for_constraints(json)
      respond_to do |format|
        format.html { render :partial => "sections/section_table", :locals => { :sections => sections.all.sample(4) } }
        format.json { render :json => sections.all }
      end
    else
      redirect_to :controller => 'schedules', :action => 'recommend_schedule'
    end
  end
end

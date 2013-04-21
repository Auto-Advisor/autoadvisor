class SchedulesController < ApplicationController
  def schedule
    @rec = Section.get_new_schedule(10)
  end

  def all_classes
  end

  def filter_class
  end

  def recommend
  	@schedules = [
      {
        name: "CMPSCI320",
        day: "TuTh",
        beg_time: "1600",
        end_time: "1715"
      }, {
        name: "CMPSCI326",
        day: "MoWeFr",
        beg_time: "1115",
        end_time: "1205"
      }, {
        name: "CMPSCI383",
        day: "TuTh",
        beg_time: "1115",
        end_time: "1230"
      }
    ]
  	respond_to do |format|
  	  format.json { render :json => @schedules }
  	  format.html
  	end
  end
end

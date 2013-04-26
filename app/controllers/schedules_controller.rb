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
            name: "CMPSCI 453",
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
    return keys
  end

  def search
    keys = params[:schedule]
    @result = getSearchResult(keys)
    respond_to do |format|
      format.json {render :json => @result }
      format.html
    end
  end
end

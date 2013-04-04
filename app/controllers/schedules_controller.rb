class SchedulesController < ApplicationController
  def schedule
    @rec = Section.get_new_schedule(10)
  end

  def all_classes
  end

  def filter_class
  end

  def recommended_schedule
  end
end

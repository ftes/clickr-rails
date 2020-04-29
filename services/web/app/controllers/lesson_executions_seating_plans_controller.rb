class LessonExecutionsSeatingPlansController < ApplicationController
  layout false

  def show
    @school_class = CurrentSchoolClass.get or
      (
        flash[:notice] = t('.select_school_class_notice') and
          redirect_to school_classes_path and return
      )
    @seating_plan = Clickr::SeatingPlan.new(@school_class)
    @edit = params[:edit_seating_plan] == 'true'
  end
end

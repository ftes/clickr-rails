class SchoolClassesSeatingPlansController < ApplicationController
  def update
    @school_class = SchoolClass.find(params[:school_class_id])

    seating_plan = seating_plan_params.map { |s| s.to_h.symbolize_keys }
    @school_class.update_seats seating_plan
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def seating_plan_params
    params.permit(students: %i[student_id seat_row seat_col]).require(:students)
  end
end

class CurrentSchoolClassesController < ApplicationController
  def update
    school_class_id = params.dig(:current_school_class, :school_class_id)
    school_class = SchoolClass.find(school_class_id)
    CurrentSchoolClass.set(school_class)

    redirect_path = lesson_evaluate_path(school_class.most_recent_lesson_or_create)
    redirect_to redirect_path, notice: t('.notice')
  end
end

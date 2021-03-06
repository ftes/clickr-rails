class LessonExecutionsController < ApplicationController
  def show
    @school_class = CurrentSchoolClass.get or
      (
        flash[:notice] = t('.select_school_class_notice') and
          redirect_to school_classes_path and return
      )
    @seating_plan = Clickr::SeatingPlan.new(@school_class)
    @edit = params[:edit_seating_plan] == 'true'
    @lesson = @school_class.most_recent_lesson_or_create
    @question = @lesson.most_recent_question
    @suggest_creating_new_lesson = @school_class.suggest_creating_new_lesson?
    @default_question_name = Question.default_name(@lesson)
  end
end

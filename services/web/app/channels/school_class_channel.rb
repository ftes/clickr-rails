class SchoolClassChannel < ApplicationCable::Channel
  CLICK = 'click'.freeze

  def subscribed
    school_class = SchoolClass.find(params[:school_class_id])
    stream_for school_class
  end
end

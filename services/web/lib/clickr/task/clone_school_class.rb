class Clickr::Task::CloneSchoolClass
  attr_reader :result

  def self.call(school_class, new_name)
    handler = self.new(school_class, new_name)
    handler.call
    handler
  end

  def initialize(
    school_class,
    new_name = I18n.t('school_classes.cloned_name', name: school_class.name)
  )
    @school_class = school_class
    @new_name = new_name
    @result = nil
  end

  def call
    return @result = nil if !@school_class

    SchoolClass.transaction do
      new_school_class = @school_class.dup
      new_school_class.name = @new_name
      new_school_class.save!

      @school_class.students.includes(:student_device_mappings)
        .each do |student|
        new_student = student.dup
        new_student.school_class = new_school_class
        new_student.save!

        student.student_device_mappings.each do |mapping|
          new_mapping = mapping.dup
          new_mapping.school_class = new_school_class
          new_mapping.student = new_student
          new_mapping.save!
        end
      end

      return @result = new_school_class
    end
  end
end

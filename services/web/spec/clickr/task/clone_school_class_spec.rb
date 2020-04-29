# TODO require only spec_helper (problems with loading lib/ modules)
require 'rails_helper'

RSpec.describe Clickr::Task::CloneSchoolClass do
  let (:school_class) { create(:school_class) }

  it 'duplicates class with students and device mappings' do
    old_student =
      school_class.students.create!(name: 'Max', seat_row: 1, seat_col: 1)
    old_mapping =
      old_student.student_device_mappings.create!(
        device_type: 'rfid', device_id: '1', school_class: school_class
      )

    cloned_school_class = described_class.call(school_class, 'new name').result
    expect(cloned_school_class.persisted?).to eq true

    expect(cloned_school_class.students.size).to eq 1
    new_student = cloned_school_class.students[0]
    expect(new_student.persisted?).to eq true
    expect(new_student.name).to eq 'Max'
    expect(new_student.id).not_to eq old_student.id

    expect(new_student.student_device_mappings.size).to eq 1
    new_mapping = new_student.student_device_mappings[0]
    expect(new_mapping.persisted?).to eq true
    expect(new_mapping.id).not_to eq old_mapping.id
    expect(new_mapping.school_class).to eq cloned_school_class
  end
end

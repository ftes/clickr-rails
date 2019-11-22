require 'test_helper'

class SchoolClassTest < ActiveSupport::TestCase
  def setup
    @subject = create(:school_class)
    @long_ago = Rails.application.config.clickr.suggest_new_lesson_after_minutes.minutes.ago - 1.minute
  end

  test 'suggest_creating_new_lesson is false if no lesson existed' do
    assert_equal true, @subject.suggest_creating_new_lesson?
  end

  test 'suggest_creating_new_lesson is false if a new lesson exists' do
    @subject.lessons.create!(name: 'lesson', created_at: 1.minute.ago)
    assert_equal false, @subject.suggest_creating_new_lesson?
  end

  test 'suggest_creating_new_lesson is true if no questions existed for an old lesson' do
    @subject.lessons.create!(name: 'lesson', created_at: @long_ago)
    assert_equal true, @subject.suggest_creating_new_lesson?
  end

  test 'suggest_creating_new_lesson is true if an old question existed for an old lesson' do
    lesson = @subject.lessons.create!(name: 'lesson', created_at: @long_ago)
    lesson.questions.create!(name: 'question', created_at: @long_ago, school_class: @subject)
    assert_equal true, @subject.suggest_creating_new_lesson?
  end

  test 'suggest_creating_new_lesson is false if an new question exists for an old lesson' do
    lesson = @subject.lessons.create!(name: 'lesson', created_at: @long_ago)
    lesson.questions.create!(name: 'question', created_at: 1.minute.ago, school_class: @subject)
    assert_equal false, @subject.suggest_creating_new_lesson?
  end

  test 'students_and_empty_seats adds empty seats (inside and as a border) and enforces positive row/col values' do
    s1, s2 = @subject.students.create! [
      { name: '1', seat_row: 1, seat_col: 1 },
      { name: '4', seat_row: 2, seat_col: 2 }
   ]
    assert_equal [
      {row: 1, col: 1, is_empty: true, student: nil, is_border: true},  {row: 1, col: 2, is_empty: true, student: nil, is_border: true},  {row: 1, col: 3, is_empty: true, student: nil, is_border: true},  {row: 1, col: 4, is_empty: true, student: nil, is_border: true},
      {row: 2, col: 1, is_empty: true, student: nil, is_border: true},  {row: 2, col: 2, is_empty: false, student: s1, is_border: false}, {row: 2, col: 3, is_empty: true, student: nil, is_border: false}, {row: 2, col: 4, is_empty: true, student: nil, is_border: true},
      {row: 3, col: 1, is_empty: true, student: nil, is_border: true},  {row: 3, col: 2, is_empty: true, student: nil, is_border: false}, {row: 3, col: 3, is_empty: false, student: s2, is_border: false}, {row: 3, col: 4, is_empty: true, student: nil, is_border: true},
      {row: 4, col: 1, is_empty: true, student: nil, is_border: true},  {row: 4, col: 2, is_empty: true, student: nil, is_border: true},  {row: 4, col: 3, is_empty: true, student: nil, is_border: true},  {row: 4, col: 4, is_empty: true, student: nil, is_border: true},
    ], @subject.seating_plan[:seats]
  end

  test 'seating_plan= updates all students in transaction (swap places)' do
    s1, s2 = @subject.students.create! [
      { name: '1', seat_row: 1, seat_col: 1 },
      { name: '4', seat_row: 2, seat_col: 2 }
   ]
    @subject.seating_plan = [
      { student_id: s1.id, row: 2, col: 2 },
      { student_id: s2.id, row: 1, col: 1 },
    ]
    s1.reload
    s2.reload
    assert_equal [2, 2], [s1.seat_row, s1.seat_col]
    assert_equal [1, 1], [s2.seat_row, s2.seat_col]
  end
end

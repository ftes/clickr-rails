require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    sign_in @user
    @student = create(:student)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    new_student = build(:student)

    assert_difference('Student.count') do
      post students_url, params: { student: { name: new_student.name, school_class_id: new_student.school_class_id, seat_col: new_student.seat_col, seat_row: new_student.seat_row } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should create incomplete device mapping when creating student if requested" do
    new_student = build(:student)

    assert_difference 'Student.count', 1 do
      assert_difference 'StudentDeviceMapping.count', 1 do
        post students_url, params: { student: { name: new_student.name, school_class_id: new_student.school_class_id, seat_col: new_student.seat_col, seat_row: new_student.seat_row, create_incomplete_mapping: true } }
      end
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { name: @student.name, school_class_id: @student.school_class_id, seat_col: @student.seat_col, seat_row: @student.seat_row } }
    assert_redirected_to student_url(@student)
  end

  test "should destroy student" do
    skip 'dependent rows in other tables'
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end

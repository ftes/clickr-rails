class CreateStudentDeviceMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :student_device_mappings do |t|
      t.references :student, null: false, foreign_key: true, index: true
      t.references :school_class, null: false, foreign_key: true, index: true
      t.string :device_id, null: true, index: true
      t.string :device_type, null: true, index: true
      t.boolean :incomplete, null: false, default: false, index: true

      t.timestamps
    end

    add_index :student_device_mappings,
              :created_at,
              order: { created_at: :desc }
    add_index :student_device_mappings,
              %i[school_class_id device_id],
              unique: true
  end
end

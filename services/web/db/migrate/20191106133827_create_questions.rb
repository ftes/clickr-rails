class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :school_class, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end

class CreateStudentResults < ActiveRecord::Migration[7.0]
  def change
    create_table :student_results do |t|
      t.string :subject
      t.datetime :submitted_time
      t.decimal :marks, :precision => 15, :scale => 10

      t.timestamps
    end
  end
end

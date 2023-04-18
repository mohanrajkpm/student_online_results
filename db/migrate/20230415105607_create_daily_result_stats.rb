class CreateDailyResultStats < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_result_stats do |t|
      t.date :daily_submitted_date
      t.string :subject
      t.decimal :daily_low, :precision => 15, :scale => 10
      t.decimal :daily_high, :precision => 15, :scale => 10
      t.integer :result_count

      t.timestamps
    end
  end
end

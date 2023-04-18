class CreateMonthlyAverages < ActiveRecord::Migration[7.0]
  def change
    create_table :monthly_averages do |t|
      t.date :monthly_date
      t.string :subject
      t.decimal :monthly_avg_low, :precision => 15, :scale => 10
      t.decimal :monthly_avg_high, :precision => 15, :scale => 10
      t.integer :monthly_result_count

      t.timestamps
    end
  end
end

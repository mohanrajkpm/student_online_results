class MonthlyAverage < ApplicationRecord
    validates :subject, presence: true, format: {with: /[a-zA-Z]/}
    validates :monthly_date, presence: true
    validates :monthly_avg_low, presence: true, numericality: { greater_than: 0, less_than: 100 }
    validates :monthly_avg_high, presence: true, numericality: { greater_than: 0, less_than: 100 }
    validates :monthly_result_count, presence: true, numericality: { greater_than: 199, less_than: 10000 }
end

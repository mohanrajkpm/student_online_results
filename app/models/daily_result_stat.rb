class DailyResultStat < ApplicationRecord
    validates :subject, presence: true, format: {with: /[a-zA-Z]/}
    validates :daily_submitted_date, presence: true
    validates :daily_low, presence: true, numericality: { greater_than: 0, less_than: 100 }
    validates :daily_high, presence: true, numericality: { greater_than: 0, less_than: 100 }
    validates :result_count, presence: true, numericality: { greater_than: 0, less_than: 10000 }
end

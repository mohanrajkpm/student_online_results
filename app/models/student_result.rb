class StudentResult < ApplicationRecord
    validates :subject, presence: true, format: {with: /[a-zA-Z]/}
    validates :submitted_time, presence: true
    validates :marks, presence: true, numericality: { greater_than: 0, less_than: 100 }
end

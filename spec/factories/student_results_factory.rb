FactoryBot.define do
  factory :student_result do
    subject { 'Science' }
    submitted_time { Time.now }
    marks { 77.86 }
  end
end

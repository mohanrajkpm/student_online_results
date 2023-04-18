FactoryBot.define do
    factory :student_result do
      subject { "Science" }
      submitted_time { Time.now }
      marks { 77.32 }
    end

    #factory :daily_result_stat do
#       daily_submitted_date { "2023-04-17" }
#       subject { 'Science' }
#       daily_low { 88.32 }
#       daily_high { 90.7 }
#       result_count { 5 }
#     end
end
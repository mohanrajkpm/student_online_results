FactoryBot.define do
    factory :daily_result_stat do
        daily_submitted_date { Date.today }
        subject { 'Science' }
        daily_low { 56.87 }
        daily_high { 89.87 }
        result_count { 21 }
    end
end
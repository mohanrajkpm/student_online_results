FactoryBot.define do
    factory :monthly_average do
        monthly_date { Date.today }
        subject { 'Science' }
        monthly_avg_low { 56.87 }
        monthly_avg_high { 89.87 }
        monthly_result_count { 211 }
    end
end
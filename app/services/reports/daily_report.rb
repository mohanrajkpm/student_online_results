class Reports::DailyReport < ApplicationService
    
    def call
        # fetch_student_response
        student_results.each do |result|
            DailyResultStat.create!(
                daily_submitted_date: Date.today,
                subject: result.subject,
                daily_low: result.daily_min,
                daily_high: result.daily_max,
                result_count: result.result_count
            )
        end
    end
    
    private

    # def fetch_student_response
    # call MSM API
    # Save student test online results
    # end
    
    def student_results
        StudentResult.where(submitted_time: Date.today.all_day)
        .group(:subject)
        .select("subject, COUNT(*) AS result_count, MIN(marks) AS daily_min, MAX(marks) AS daily_max")
    end
end
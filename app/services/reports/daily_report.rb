class Reports::DailyReport < ApplicationService
        
    def initialize; end

    def call
        # save_student_results
        student_results.each do |st|
            DailyResultStat.create(daily_submitted_date: Date.today, subject: st.subject, daily_low: st.daily_min, daily_high: st.daily_max, result_count: st.result_count)
        end
    end

    private

    def save_student_results
        # curretly we don't have response object, so, manually inserted student results.
        # StudentResult.create(subject: response.subject, submitted_time: response.timestamp, marks: response.marks )
    end

    def student_results
        StudentResult.where("DATE(submitted_time) = ?", Date.today).select("subject, COUNT(*) AS result_count, MIN(marks) AS daily_min, MAX(marks) AS daily_max ").group(:subject)
    end
end
class Reports::MonthlyReport < ApplicationService

    def initialize(expected_day = 'Monday', expected_week = 3, minimum_volume = 200, minimum_days = 4)
        @expected_day = expected_day
        @expected_week = expected_week
        @minimum_days = minimum_days
        @minimum_volume = minimum_volume
    end

    def call
        if monthly_calculation_day?
            @results = check_minimum_volume
            save
        end
    end

    private

    attr_reader :expected_week, :expected_day, :minimum_days, :minimum_volume

    def monthly_calculation_day?
        Date.today.month_week == @expected_week && Date.today.strftime("%A") == @expected_day
    end

    def check_minimum_volume(minimum_days = nil)
        @minimum_days ||= minimum_days
        result = DailyResultStat.where('daily_submitted_date BETWEEN ? AND ?', Date.today - @minimum_days, Date.today)        
        if result.sum(:result_count) >= @minimum_volume
            return result.select('subject, AVG(daily_low) AS avg_low, AVG(daily_high) AS avg_high, SUM(result_count) AS result_volume').group(:subject)
        end
        check_minimum_volume(@minimum_days+=1)
    end

    def save
        if @results.present?
            @results.each do |v|
                MonthlyAverage.create(monthly_date: Date.today, subject: v.subject, monthly_avg_low: v.avg_low, monthly_avg_high: v.avg_high, monthly_result_count: v.result_volume)
            end
        end
    end
end
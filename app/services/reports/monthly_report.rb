class Reports::MonthlyReport < ApplicationService
    MINIMUM_DAYS = 4
    MINIMUM_VOLUME = 200
    EXPECTED_WEEK = 3
    EXPECTED_DAY = 'Monday'
  
    def initialize(expected_day = EXPECTED_DAY, expected_week = EXPECTED_WEEK, minimum_volume = MINIMUM_VOLUME, minimum_days = MINIMUM_DAYS)
      @expected_day = expected_day
      @expected_week = expected_week
      @minimum_days = minimum_days
      @minimum_volume = minimum_volume
    end
  
    def call
      return unless monthly_calculation_day?
  
      daily_result_stats = DailyResultStat.group(:subject).select(:subject, "SUM(result_count) AS result_volume")
      daily_result_stats.each do |stats|
        next unless stats.result_volume >= @minimum_volume
  
        @subject = stats.subject
        @results = check_minimum_volume
        save if @results.present?
      end
    end
  
    private
  
    def monthly_calculation_day?
      Date.today.month_week == @expected_week && Date.today.strftime('%A') == @expected_day
    end
  
    def check_minimum_volume(minimum_days = @minimum_days)
        result = DailyResultStat.where('subject LIKE ? AND daily_submitted_date BETWEEN ? AND ?',@subject,  Date.today - @minimum_days, Date.today)        
        if result.sum(:result_count) >= @minimum_volume
            return result.select('subject, AVG(daily_low) AS avg_low, AVG(daily_high) AS avg_high, SUM(result_count) AS result_volume').group(:subject)
        end
        check_minimum_volume(@minimum_days+=1)
    end
  
    def save
      @results.each do |result|
        MonthlyAverage.create(monthly_date: Date.today, subject: result.subject, monthly_avg_low: result.avg_low, monthly_avg_high: result.avg_high, monthly_result_count: result.result_volume)
      end
    end
end
  
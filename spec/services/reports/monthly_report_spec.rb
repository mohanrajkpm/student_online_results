require 'rails_helper'

RSpec.describe Reports::MonthlyReport do
    describe "#call" do
      context "when today is the expected monthly calculation day" do
        let(:expected_day) { Date.today.strftime("%A") }
        let(:expected_week) { Date.today.month_week }
        let(:minimum_volume) { 200 }
        let(:minimum_days) { 4 }
        let!(:daily_result_stat_1) { create(:daily_result_stat, daily_submitted_date: Date.today - 2.days, subject: "Math", result_count: 50, daily_low: 10, daily_high: 20) }
        let!(:daily_result_stat_2) { create(:daily_result_stat, daily_submitted_date: Date.today - 3.days, subject: "Science", result_count: 150, daily_low: 5, daily_high: 15) }
        let!(:daily_result_stat_3) { create(:daily_result_stat, daily_submitted_date: Date.today - 3.days, subject: "Science", result_count: 55, daily_low: 5, daily_high: 15) }
        let!(:daily_result_stat_4) { create(:daily_result_stat, daily_submitted_date: Date.today - 4.days, subject: "English", result_count: 75, daily_low: 15, daily_high: 25) }
        
        it "creates a new monthly average record for subjects with total result count greater than or equal to minimum volume in last minimum days" do
          expect { Reports::MonthlyReport.call(expected_day, expected_week, minimum_volume, minimum_days) }.to change { MonthlyAverage.count }.by(1)
          math_monthly_average = MonthlyAverage.find_by(subject: "Math")
          science_monthly_average = MonthlyAverage.find_by(subject: "Science")
          expect(science_monthly_average).to have_attributes(monthly_date: Date.today, monthly_avg_low: 5.0, monthly_avg_high: 15.0, monthly_result_count: 205)
        end
        
        it "does not create a new monthly average record for subjects with total result count less than minimum volume in last minimum days" do
          expect { Reports::MonthlyReport.call('Friday', expected_week, minimum_volume, minimum_days) }.not_to change { MonthlyAverage.count }.from(0)
        end
      end
      
      context "when today is not the expected monthly calculation day" do
        let(:expected_day) { "Monday" }
        let(:expected_week) { 1 }
        let(:minimum_volume) { 200 }
        let(:minimum_days) { 4 }
        let!(:daily_result_stat) { create(:daily_result_stat, daily_submitted_date: Date.today - 2.days, subject: "Math", result_count: 500, daily_low: 10, daily_high: 20) }
        
        it "does not create a new monthly average record" do
          expect { Reports::MonthlyReport.call(expected_day, expected_week, minimum_volume, minimum_days) }.not_to change { MonthlyAverage.count }.from(0)
        end
      end
    end
end
  
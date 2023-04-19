require 'rails_helper'

RSpec.describe DailyResultStat, type: :model do
    describe "factory" do
        it "creates a valid daily result stats" do
            daily_result_stat = FactoryBot.create(:daily_result_stat)
            expect(daily_result_stat).to be_valid
        end
    end

    describe "validations" do
        let(:daily_result_stat) { FactoryBot.build(:daily_result_stat) }

        it "requires a daily submitted date" do
            daily_result_stat.daily_submitted_date = nil
            expect(daily_result_stat).not_to be_valid
        end

        it "requires a subject" do
            daily_result_stat.subject = nil
            expect(daily_result_stat).not_to be_valid
        end

        it "requires a daily low value" do
            daily_result_stat.daily_low = nil
            expect(daily_result_stat).not_to be_valid
        end

        it "requires a daily high value" do
            daily_result_stat.daily_high = nil
            expect(daily_result_stat).not_to be_valid
        end

        it "requires a result count" do
            daily_result_stat.result_count = nil
            expect(daily_result_stat).not_to be_valid
        end

        it "requires the daily high value to be greater than or equal to the daily low value" do
            daily_result_stat.daily_low = 100
            daily_result_stat.daily_high = 50
            expect(daily_result_stat).not_to be_valid
        end
    end
end
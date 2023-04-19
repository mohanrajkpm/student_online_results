require 'rails_helper'

RSpec.describe Reports::DailyReport, type: :service do
    describe '#call' do
      let(:today) { Date.today }
      let!(:result_1) { FactoryBot.create(:student_result, subject: 'Science', submitted_time: today, marks: 90.55) }
      let!(:result_2) { FactoryBot.create(:student_result, subject: 'Math', submitted_time: today, marks: 85.25) }
      let!(:result_3) { FactoryBot.create(:student_result, subject: 'Science', submitted_time: today, marks: 75.32) }
  
      it 'creates a DailyResultStat for each subject with the correct values' do
        expect {
          described_class.call
        }.to change(DailyResultStat, :count).by(2)
  
        science_stat = DailyResultStat.find_by(subject: 'Science')
        expect(science_stat.daily_submitted_date).to eq(today)
        expect(science_stat.daily_low.to_f).to eq(75.32)
        expect(science_stat.daily_high.to_f).to eq(90.55)
        expect(science_stat.result_count).to eq(2)
  
        math_stat = DailyResultStat.find_by(subject: 'Math')
        expect(math_stat.daily_submitted_date).to eq(today)
        expect(math_stat.daily_low).to eq(85.25)
        expect(math_stat.daily_high).to eq(85.25)
        expect(math_stat.result_count).to eq(1)
      end
    end
  end
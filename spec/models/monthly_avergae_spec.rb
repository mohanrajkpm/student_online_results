require 'rails_helper'

RSpec.describe MonthlyAverage, type: :model do
    describe 'factory' do
        it 'is valid' do
        monthly_average = FactoryBot.build(:monthly_average)
        expect(monthly_average).to be_valid
        end
    end

    describe 'attributes' do
        let(:monthly_average) { FactoryBot.build(:monthly_average) }

        it 'has a valid monthly_date' do
            expect(monthly_average.monthly_date).to be_a(Date)
        end

        it 'has a valid subject' do
            expect(monthly_average.subject).to eq('Science')
        end

        it 'has a valid monthly_avg_low' do
            expect(monthly_average.monthly_avg_low).to eq(56.87)
        end

        it 'has a valid monthly_avg_high' do
            expect(monthly_average.monthly_avg_high).to eq(89.87)
        end

        it 'has a valid monthly_result_count' do
            expect(monthly_average.monthly_result_count).to eq(211)
        end
    end
end
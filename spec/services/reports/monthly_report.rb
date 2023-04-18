require 'rails_helper'


RSpec.describe Reports::DailyResultStat, type: :model do
    describe '#call' do
        let(:sender) { create(:user) }
        let!(:sender_account) { create(:account, balance: 1_000, user: sender) }
  
        let(:receiver) { create(:user) }
        let!(:receiver_account) { create(:account, balance: 0, user: receiver) }

        it 'subtract sender money, add receiver money, create both transactions' do
            Reports::MonthlyReport.call
      
            expect(sender_account.balance).to eq(500)
            expect(receiver_account.balance).to eq(500)
        end
    end
end
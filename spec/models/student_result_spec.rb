require 'rails_helper'

RSpec.describe StudentResult, type: :model do
    
    describe "factory" do
        it "creates a valid student result" do
            student_result = FactoryBot.create(:student_result)
            expect(student_result).to be_valid
        end
    end
    
    describe "validations" do
        let(:student_result) { FactoryBot.build(:student_result) }

        it "requires a subject" do
            student_result.subject = nil
            expect(student_result).not_to be_valid
        end

        it "requires a submitted time" do
            student_result.submitted_time = nil
            expect(student_result).not_to be_valid
        end

        it "requires marks to be within range" do
            student_result.marks = -1
            expect(student_result).not_to be_valid

            student_result.marks = 101
            expect(student_result).not_to be_valid
        end
    end
end
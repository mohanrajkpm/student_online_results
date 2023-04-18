namespace :reports do
  desc "TODO"
  task all: :environment do
    Reports::DailyReport.call
    Reports::MonthlyReport.call
  end
end
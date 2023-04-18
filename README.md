# README

Software Requirements
---------------------

* Install Rails 7

* Install Ruby version 3.X

* Instal Postgresql 

Add below gem
=============

Cron Job
--------------------------

gem 'whenever'

Execute an Application
==================

Clone a repository
------------------

git clone git@github.com:mohanrajkpm/Price_app.git

Enter into an application
-------------------------

cd student_online_result

bundle install

rails s

whenever --update-crontab


Documentation for Student Result
================================


Every day 6PM this task will be running. Currently in local I added "whenever" gem for local development CRON Job. If we are moving Heroku or someother cloud we can use "Sidekiq-cron" gem.

Steps which is following for running our CRON Job
-------------------------------------------------

a.First it will call "Report::DailyReport" service.
b.DailyReport will run 
    1 First it will expose MSM Data API
    2 Save "StudentResults"
    3 Fetch data from StudentResults
    4 Save daily results stat into DailyResultStats
c.Second it will call "Report::MonthlyReport" service.
d.MonthlyReport will run
    1 First it fetch DailyReportStat for 5 day untill more to reach goal 200
    2.After getting data save into MonthlyReport.




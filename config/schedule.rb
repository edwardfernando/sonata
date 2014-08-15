set :environment, "development"
set :output, {:error => "/home/deploy/sonata/logs/cron/error_log.log", :standard => "/home/deploy/sonata/logs/cron/cron_log.log"}

every 1.day, :at => "10:00 am" do
  rake "reminder:schedule"
  rake "reminder:not_confirmed"
end

every 1.day, :at => "17:22 pm" do
  rake "reminder:schedule"
  rake "reminder:not_confirmed"
end

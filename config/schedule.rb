set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, :at => "10:00 am" do
  rake "reminder:schedule"
  rake "reminder:not_confirmed"
end

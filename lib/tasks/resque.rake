require 'resque/tasks'

task 'resque:setup' => :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (to run workers on Heroku)"
task "jobs:work" => "resque:work"

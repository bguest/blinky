namespace :dev do
  desc 'Start development server locally'
  task :server => :environment do
    exec('rails server -p3000')
  end
end

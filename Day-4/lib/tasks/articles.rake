# lib/tasks/articles.rake
namespace :articles do
  desc "Remove articles that have been reported 6 or more times"
  task remove_over_reported: :environment do
    removed = Article.where("reports_count >= ?", 6).destroy_all
    puts "Removed #{removed.size} over-reported article(s)."
  end
end

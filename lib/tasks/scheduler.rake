desc "validates automatically unconfirmed matches (pending status) with greater than 24h lifespan"
task :validate_pending_matches => :environment do
  puts "Finds match results with confirmed status is false"
  pending = MatchResult.where(confirmed: false).where("created_at < ? or updated_at < ?", 1.day.ago, 1.day.ago)
  pending.each do |pending_match|
    pending_match.confirm
  end
  puts "done."
end

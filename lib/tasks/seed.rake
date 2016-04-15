namespace :seed do
  desc "Makes all genderless users male and all orientationless users gay, then creates valid matches"
  task fill_in_user_data: :environment do
    User.all.each do |u|
      u.gender = true if u.gender.nil?
      u.orientation = 'gay' if u.orientation.nil?
      u.save
    end

    Match.create_valid_matches
  end

end

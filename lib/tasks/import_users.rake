require 'csv'
namespace :users do

  task :import do
    CSV.foreach('db/users.csv', headers: true) do |row|
      user = User.create!(name: row[0], email: row[1], global_admin: row[2], timezone: row[3], receive_marketing: row[4], external_id: row[5])

      row[6]&.split(", ")&.each do |name|
        skill = Skill.create_or_find_by!(name: name)
        user.skills << skill
      end
    end
  end

end

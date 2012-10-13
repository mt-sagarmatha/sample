require 'faker'

namespace :db do 
	desc "fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		User.create!(name:"emin israfil",
								 email: "emin@gmail.com",
								 password:"password",
								 password_confirmation: "password")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name, email:email, password:password, password_confirmation:password)
		end

		User.all(limit:6).each do |user|
			50.times do 
				user.microposts.create!(:content => "HELP DA BEARS")
			end
		end

	end
end
Factory.define :user do |user|
	user.name                  "emin"
	user.email                 "emin@gmail.com"
	user.password              "foofoobar"
	user.password_confirmation "foofoobar"
end

Factory.sequence :email do |n|
	"person-#{n}@example.com"
end
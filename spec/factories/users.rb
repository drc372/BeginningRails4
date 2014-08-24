FactoryGirl.define do 
	factory :user do
		password "Password1"
		password_confirmation "Password1"
		sequence(:email) { |n| "testuser#{n}@email.com"}
	end 
end
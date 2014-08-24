FactoryGirl.define do 
	factory :article do
		association :user
		title "Test Article1 Title"
		body "Test Article1 body"

		factory :invalid_article do 
			title nil
		end
	end 
end
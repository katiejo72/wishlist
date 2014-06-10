FactoryGirl.define do
	factory :user do
		fname "Human"
		sequence(:lname) { |n| "#{n}" }
		sequence(:email) { |n| "human_#{n}@example.com" }
		password "foobarbaz"
		password_confirmation "foobarbaz"

		factory :admin do
			admin true
		end
	end
end
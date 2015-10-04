FactoryGirl.define do
  factory :user do
  	sequence (:name) {|n| "Person #{n}"}
  	sequence (:email) {|n| "person_#{n}@gmail.com"}
  	password "111222333"
  	password_confirmation "111222333"

  	factory :admin do
  	  admin true
  	end
  end	
end
first_day_of_month = Date.new(rand(2005..2015), rand(1..12), 1)

FactoryGirl.define do
  factory :tuition_payment do
    date { Faker::Time.between(first_day_of_month, 1.month.since(first_day_of_month)) }
    month { first_day_of_month }
    amount { Faker::Number.between(10000, 50000) }
  end
end

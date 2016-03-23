FactoryGirl.define do
  factory :marco_general do
    association :partido, factory: :partido1
  end
end

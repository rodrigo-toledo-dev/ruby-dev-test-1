require 'faker'
FactoryBot.define do
  factory :file_system_invalid, class: "FileSystem" do
  end

  factory :file_system do
    name  { Faker::Name.middle_name.downcase }
    trait :with_parent do
      parent { create(:file_system) }
    end
  end
end

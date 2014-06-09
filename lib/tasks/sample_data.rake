namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(fname: "Example",
                 lname: "User",
                 email: "example@railstutorial.org",
                 password: "foobarbaz",
                 password_confirmation: "foobarbaz")
    99.times do |n|
      fname  = Faker::Name.first_name
      lname = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(fname: fname,
                   lname: lname,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
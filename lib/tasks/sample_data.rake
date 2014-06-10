namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(fname: "Katie",
                 lname: "Arbuckle",
                 email: "katiejo72@gmail.com",
                 password: "foobarbaz",
                 password_confirmation: "foobarbaz",
                 admin: true)
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
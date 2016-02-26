# User
User.create!(name:  "Mod",
             email: "admin@framgia.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true)
99.times do |n|
  name  = "Test-#{n+1}"
  email = "example-#{n+1}@framgia.com"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
# Category
Category.create!(name: "500 Basic Words",
                 description: "Based on the combined results of British English")
Category.create!(name: "1000 Adv Words",
                 description: "American English and Australian English surveys")
Category.create!(name: "1500 Words",
                 description: "TV, radio and real life conversations")
Category.create!(name: "2000 Adv Words",
                 description: "The language as it is written and spoken today")


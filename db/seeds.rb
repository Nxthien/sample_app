User.destroy_all
User.create!  name: "TTTTTTTTTT",
              email: "222@gmail.com",
              password: "123456789",
              password_confirmation: "123456789",
              admin: true,
              activated: true,
              activated_at: Time.zone.now

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  image = Faker::Avatar.image
  User.create!  name: name,
                email: email,
                password: password,
                password_confirmation: password, admin: false,
                image: image,
                activated: true,
                activated_at: Time.zone.now
end

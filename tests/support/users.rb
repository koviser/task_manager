module Users 

  1.upto(3) do |n|
    define_method("user#{n}") do
      User.find_by_email("user#{n}@example.com") || User.create({email: "user#{n}@example.com", password: 'password', password_confirmation: 'password'})
    end
  end
 
end
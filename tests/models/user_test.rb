# # test.rb
require File.expand_path '../../test_helper.rb', __FILE__

class UserTest < MyTest  

  test "free parameters" do
    us = User.create()
    assert !us.save
  end

  test "no email" do
    us = User.create({password: "123456789", password_confirmation: "123456789"})
    assert !us.save
  end

  test "no password" do
    us = User.create({email: "emailtest@example.com"})
    assert !us.save
  end

  test "no password_confirmation " do
    us = User.create({email: "emailtest@example.com", password: "123456789"})
    assert !us.save
  end

  test "enother password" do
    us = User.create({email: "emailtest@example.com", password: "123456789", password_confirmation: "987654321"})
    assert !us.save
  end

  test "short password" do
    us = User.create({email: "emailtest@example.com", password: "123", password_confirmation: "123"})
    assert !us.save
  end

  test "database has user" do
    us = User.create({email: user1.email, password: "123", password_confirmation: "123"})
    assert !us.save
  end

  test "user created" do
    assert User.create({email: "emailtest@example.com", password: "123", password_confirmation: "123"})
  end
end
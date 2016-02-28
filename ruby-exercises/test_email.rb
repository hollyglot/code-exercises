require 'test/unit'

class User
  attr_accessor :email

  def initialize(email)
    @email = email
  end
end


# Test if user's email is unique when a User record is created
class TestUserEmailUniqueness < Test::Unit::TestCase

  def test_email_uniqueness
    user = User.new('boo@bar.com')
    assert(true, User.where(:email => user.email).nil?)
  end

end


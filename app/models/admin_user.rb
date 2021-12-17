class AdminUser < ApplicationRecord

  # self.table_name = "admin_users"
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  has_secure_password

  EMAIL_REG = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  FORBIDDEN_USERNAMES = %w[humtydumpty sexy1111 mr.robt]

  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 25
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 50
  validates :username,  :presence => true,
                        :uniqueness => true,
                        :length => {:within => 2...25}

  validate :check_valid_username

  validates :email, :presence => true,
                    :length => {:maximum => 50},
                    :uniqueness => true,
                    :format => { :with => EMAIL_REG},
                    :confirmation => true

  private

  def check_valid_username
    puts "Test"
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "user name has been restricted")
      puts "test two"
    end
  end

end

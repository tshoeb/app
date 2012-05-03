require 'digest'
class Host < ActiveRecord::Base
	email_regex = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
	attr_accessor :password
	attr_accessible :first_name, :last_name, :email, :password
	validates :first_name, :presence => true,
					       :length => { :maximum => 50 }
	validates :last_name, :presence => true,
					      :length => { :maximum => 50 }
	validates :email, :presence => true,
					  :format => { :with => email_regex },
					  :uniqueness => { :case_sensitive => false }
	validates :password, :presence => true,
						 :confirmation =>true,
						 :length => { :within => 6..40 }
						 
	before_save :encrypt_password
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email,submitted_password)
		host = find_by_email(email)
		return nil if host.nil?
		return host if host.has_password?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		host = find_by_id(id)
		(host && host.salt == cookie_salt) ? user : nil
	end
	
	private
	
	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypt_password = encrypt(self.password)
	end
	
	def encrypt(string)
		secure_hash("#{salt}--#{string}")
	end
	
	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end
	
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
end

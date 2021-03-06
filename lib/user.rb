require 'bcrypt'
require 'pg'
require 'pry'
require_relative './database_connection'

class User

  attr_reader :first_name, :last_name, :email, :username, :user_id, :password

  def initialize(first_name, last_name, email, username, user_id, password)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @username = username
    @user_id = user_id
    @password = password
  end

  def self.create(first_name, last_name, email, username, password)
    return if has_email(email) # Aborts if email already exists
    return if has_username(username) # Aborts if username already exists
    encrypted_password = BCrypt::Password.create(password)
    res = DatabaseConnection.query("INSERT INTO users (first_name, last_name, \
      email, username, password) VALUES ('#{first_name}', '#{last_name}', \
        '#{email}', '#{username}', '#{encrypted_password}') returning *;")
    User.new(res[0]['first_name'], res[0]['last_name'], res[0]['email'], \
      res[0]['username'], res[0]['user_id'], res[0]['password'])
  end

  def self.all_users
    res = DatabaseConnection.query("SELECT * FROM users;")
    res.map { |user| User.new(user['first_name'], user['last_name'], \
      user['email'], user['username'], user['user_id'], user['password']) }
  end

  def self.find(id)
    res = DatabaseConnection.query("SELECT * FROM users \
      WHERE user_id = '#{id}'")
    return if res.ntuples.zero?
    User.new(res[0]['first_name'], res[0]['last_name'], res[0]['email'], \
      res[0]['username'], res[0]['user_id'], res[0]['password'])
  end

  def self.has_email(email)
    res = DatabaseConnection.query("SELECT * FROM users \
      WHERE email = '#{email}'")
    !res.ntuples.zero?
  end

  def self.has_username(username)
    res = DatabaseConnection.query("SELECT * FROM users \
      WHERE username = '#{username}'")
    !res.ntuples.zero?
  end

  def self.authenticate(username, password)
    res = DatabaseConnection.query("SELECT * FROM users \
      WHERE username = '#{username}'")
    return unless res.any?
    return unless BCrypt::Password.new(res[0]['password']) == password
    User.new(res[0]['first_name'], res[0]['last_name'], res[0]['email'], \
      res[0]['username'], res[0]['user_id'], res[0]['password'])
  end

end

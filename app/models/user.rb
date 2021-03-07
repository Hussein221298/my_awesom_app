# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  @role_options = %w[member admin]
  self.class.attr_reader :role_options
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: @role_options, message: '%<value>s is not a valid role' }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name=(val)
    pieces = val.split
    self.first_name = pieces[0]
    self.last_name = pieces[1]
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

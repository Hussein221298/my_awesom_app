# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  @ROLE_OPTIONS = %w[member admin]
  self.class.attr_reader :ROLE_OPTIONS

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  validates :role, inclusion: { in: @ROLE_OPTIONS, message: '%<value>s is not a valid role' }

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

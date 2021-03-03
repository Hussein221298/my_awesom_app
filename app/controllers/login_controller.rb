# frozen_string_literal: true

class LoginController < ApplicationController
  def index
    @users = User.all
  end
end

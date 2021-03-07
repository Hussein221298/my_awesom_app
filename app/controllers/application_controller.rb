# frozen_string_literal: true

class ApplicationController < ActionController::Base

  include UsersHelper
  include SessionsHelper
end

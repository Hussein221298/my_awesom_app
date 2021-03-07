# frozen_string_literal: true

module UsersHelper
  def require_login
    redirect_to '/' unless logged_in?
  end
end

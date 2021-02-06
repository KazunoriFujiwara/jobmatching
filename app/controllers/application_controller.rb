class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def require_company_clogged_in
    unless clogged_in?
      redirect_to clogin_url
    end
  end
end

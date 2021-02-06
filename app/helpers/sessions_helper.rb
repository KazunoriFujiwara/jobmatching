module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def current_company
    @current_company ||= Company.find_by(id: session[:company_id])
  end
  
  def clogged_in?
    !!current_company
  end
end

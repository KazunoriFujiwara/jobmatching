class SessionsController < ApplicationController
  
  def new
    if logged_in?
      redirect_to root_url
    elsif clogged_in?
      redirect_to root_url
    end
  end
  
  def c_new
    if logged_in?
      redirect_to root_url
    elsif clogged_in?
      redirect_to root_url
    end
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if current_company == nil && current_user == nil
      if login(email, password)
        flash[:success] = 'ログインに成功しました。'
        redirect_to root_url
      else
        flash.now[:danger] = 'ログインに失敗しました。'
        render :new
      end
    else
      flash.now[:danger] = '複数のログインに失敗しました。'
        render :new 
    end
    
  end
  
  def c_create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if current_company == nil && current_user == nil
      if clogin(email, password)
        flash[:success] = 'ログインに成功しました。'
        redirect_to root_url
      else
        flash.now[:danger] = 'ログインに失敗しました。'
        render :c_new
      end
    else
      flash.now[:danger] = '複数のログインに失敗しました。'
        render :c_new 
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  def c_destroy
    session[:company_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    puts current_company
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
  
  def clogin(email, password)
    @company = Company.find_by(email: email)
    if @company && @company.authenticate(password)
      # ログイン成功
      session[:company_id] = @company.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end
  
  def c_create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if clogin(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @company
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
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

class UsersController < ApplicationController
  #before_action :require_user_logged_in, only: [:index, :show, :corporationes, :applies, :undertakes, :searches]

  def index
    if logged_in?
     redirect_to root_url
    elsif clogged_in?
     redirect_to root_url
    else
     redirect_to login_url
    end
  end

  def show
    if logged_in?
      @user = current_user
      if User.find_by(id: params[:id]) == nil
        redirect_to root_url
      else
        @x = User.find(params[:id])
        @jobs = Job.all
        if relationshiip = Relationship.find_by(user_id: @x.id) == nil
          redirect_to root_url
        else
          @jobs.each do |job|
            relationshiip = Relationship.find_by(job_id: job.id) 
            unless relationshiip == nil then
              if @x.id == relationshiip.user.id
                if job.company_id == current_company.id
                  @user = User.find(params[:id])
                  break
                else
                redirect_to root_url
                end
              end
            end
          end
        end
      end
    else
      redirect_to login_url
    end
    
  end

  def new
    require_new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
 
  def corporationes
    @user = current_user
    @companies = Company.all
  end

  def applies
    require_applies
  end
  
  def undertakes
    require_undertakes
  end

  def searches
    require_searches
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def require_applies
    if logged_in?
      @user = current_user
      @undertakes = @user.undertakes.page(params[:page])
    elsif clogged_in?
      redirect_to root_url
    else
      redirect_to login_url
    end
  end
  def require_new
    if logged_in?
      redirect_to root_url
    elsif clogged_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end
  
  def require_undertakes
    if logged_in?
      @user = User.find(params[:id])
      @jobs = @user.undertakes.page(params[:page])
    elsif clogged_in?
      redirect_to root_url
    else
      redirect_to login_url
    end
  end
  
  def require_searches
    if logged_in?
      @user = current_user
      @jobs = Job.search(params[:search])
    elsif clogged_in?
      redirect_to root_url
    else
      redirect_to login_url
    end
  end
end

class UsersController < ApplicationController
  #before_action :require_user_logged_in, only: [:index, :show, :corporationes, :applies, :undertakes, :searches]
  before_action :require_permission
  
  def require_permission
    if logged_in?
    elsif clogged_in?
    else
    end
  end
  
  def index
    redirect_to root_url
    #@users = User.order(id: :desc).page(params[:page]).per(25)  #User.order(id: :desc) で id の降順にユーザの一覧を取得
  end

  def show
    if logged_in?
      @user = current_user
    else
      @x = User.find(params[:id])
      #@companies = Company.all
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
                puts 'hello'
                break
              else
              redirect_to root_url
              end
            end
          end
        end
      end
    end
    
  end

  def new
    @user = User.new
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
    @user = current_user
    @undertakes = @user.undertakes.page(params[:page])
  end
  
  def undertakes
    @user = User.find(params[:id])
    @jobs = @user.undertakes.page(params[:page])
  end

  def searches
    #@user = User.find(params[:id])
    @user = current_user
    @jobs = Job.search(params[:search])
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

class CompaniesController < ApplicationController
  before_action :require_permission
  
  def require_permission
    if logged_in?
    elsif clogged_in?
    else
      #redirect_to login_url
      #require_user_clogged_in, only: [:index, :show, :corporationes, :applies, :undertakes, :searches]
    end
  end
  
  def index
    redirect_to root_url
  end

  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs.order(id: :desc).page(params[:page])
  end

  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(company_params)

    if @company.save
      flash[:success] = '企業様を登録しました。'
      redirect_to @company
    else
      flash.now[:danger] = '企業様の登録に失敗しました。'
      render :new
    end
  end
  
  def appliers
    @company = current_company
    array = Array.new
    @members  = Array.new
    jobs = @company.jobs.order(id: :desc)
    jobs.each do |job|
      unless Relationship.find_by(job_id: job.id)==nil then
        a =  Relationship.where(job_id: job.id).pluck(:id).size
        if a > 1 then
          ary = Relationship.where(job_id: job.id).pluck(:id)
          ary.each do |youso|
            array.push(youso)
          end
        elsif
          array.push(Relationship.where(job_id: job.id).pluck(:id))
        end
      end
    end
  end
  
  private

  def company_params
    params.require(:company).permit(:name, :email, :password, :password_confirmation)
  end
  
end

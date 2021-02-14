class CompaniesController < ApplicationController
  def index
    if logged_in?
     redirect_to root_url
    elsif clogged_in?
     redirect_to root_url
    else
     redirect_to clogin_url
    end
  end

  def show
    if clogged_in?
      @company = current_company
      @jobs = @company.jobs.order(id: :desc).page(params[:page])
    elsif logged_in?
      if Company.find_by(id: params[:id]) == nil
        redirect_to root_url
      else
        @company = Company.find(params[:id])
        @jobs = @company.jobs.order(id: :desc).page(params[:page])
      end
    else
      redirect_to clogin_url
    end
  end

  def new
    require_new
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
  
  def require_new
    if logged_in?
      redirect_to root_url
    elsif clogged_in?
      redirect_to root_url
    else
      @company = Company.new
    end
  end
  
end

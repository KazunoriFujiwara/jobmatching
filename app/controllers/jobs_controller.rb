class JobsController < ApplicationController
  before_action :require_permission
  
  def require_permission
    if logged_in?
    elsif clogged_in?
    else
      redirect_to login_url
    end
  end

  before_action :correct_company, only: [:destroy]
  
  def index
    redirect_to root_url
  end

  def new
    @job = Job.new
  end
  
  def show
    @job = Job.find(params[:id])
  end
  
  def create
    @job = current_company.jobs.build(job_params)
    if @job.save
      flash[:success] = 'お仕事を登録しました。'
      redirect_to root_url
    else
      @jobs = current_company.jobs.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'お仕事の登録に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @job.destroy
    flash[:success] = 'お仕事を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def search
    @jobs = Job.search(params[:search])
  end
  
  private

  def job_params
    params.require(:job).permit(:content,:start_date,:start_time,:end_date,:end_time,:place)
  end
  
  def correct_company
    @job = current_company.jobs.find_by(id: params[:id])
    unless @job
      redirect_to root_url
    end
  end
end

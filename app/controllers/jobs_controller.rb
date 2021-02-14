class JobsController < ApplicationController
  before_action :require_permission
  require "active_support/time"
  require "time"
  
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
  
  def update
    job = Job.find(params[:id])
    job.update_attribute(:status, "委託確定")
    flash[:success] = '委託を確定しました。'
    redirect_to root_url
  end
  
  def show
    @job = Job.find(params[:id])
  end

  def create
    @job = current_company.jobs.build(job_params)
     msg = ''
    unless @job.content?
      a =  '未入力箇所: お仕事内容'
    else
      a = '未入力箇所:'
    end
    unless @job.start_date?
      a = a+' 開始日'
    end
    unless @job.start_time?
      a = a+' 開始時間'
    end
    unless @job.end_date?
      a = a+' 終了日'
    end
    unless @job.end_time?
      a = a+' 終了時間'
    end
    unless @job.place?
      a = a+' お仕事の場所'
    end
    unless a== '未入力箇所:'
      msg = a
    end
    if a == '未入力箇所:'
      time = Time.now + 9.hour
      jsdy = @job.start_date.strftime('%Y')
      jsdm = @job.start_date.strftime('%m')
      jsdd = @job.start_date.strftime('%d')
      jsh = @job.start_time.strftime('%H')
      jsm = @job.start_time.strftime('%M')
      jedy = @job.end_date.strftime('%Y')
      jedm = @job.end_date.strftime('%m')
      jedd = @job.end_date.strftime('%d')
      jeh = @job.end_time.strftime('%H')
      jem = @job.end_time.strftime('%M')

      str1 = jsdy + '/' + jsdm + '/' + jsdd + ' ' + jsh + ':' + jsm
      tm1 = Time.parse(str1)
      str2 = jedy + '/' + jedm + '/' + jedd + ' ' + jeh + ':' + jem
      tm2 = Time.parse(str2)
      
      if time > tm1
        msg = '時間の入力に誤りがあります'
      elsif tm1 > tm2
        msg = '時間の入力に誤りがあります'
      end
    end
    if msg == '時間の入力に誤りがあります'
      @jobs = current_company.jobs.order(id: :desc).page(params[:page])
        flash.now[:danger] = 'お仕事の登録に失敗しました。'+ msg
        render :new
    else
      if @job.save
        flash[:success] = 'お仕事を登録しました。'
        redirect_to root_url
      else
        @jobs = current_company.jobs.order(id: :desc).page(params[:page])
        flash.now[:danger] = 'お仕事の登録に失敗しました。'
        #render 'toppages/index'
        render :new
      end
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
    params.require(:job).permit(:content,:start_date,:start_time,:end_date,:end_time,:place,:status,:update)
  end
  
  def correct_company
    @job = current_company.jobs.find_by(id: params[:id])
    unless @job
      redirect_to root_url
    end
  end
end

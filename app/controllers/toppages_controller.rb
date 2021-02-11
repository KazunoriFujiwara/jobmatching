class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @companies = Company.all
      @jobs = Job.all.page(params[:page])
    end
    if clogged_in?
      @job = current_company.jobs.build
      @jobs = current_company.jobs.order(id: :desc).page(params[:page])
    end
  end
end

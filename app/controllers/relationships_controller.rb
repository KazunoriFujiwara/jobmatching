class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  def create
    job = Job.find(params[:job_id])
    current_user.apply(job)
    flash[:success] = '仕事を受託しました。'
    redirect_to user_path(current_user)
  end

  def destroy
    job = Job.find(params[:job_id])
    current_user.withdraw(job)
    flash[:success] = '受託をキャンセルしました。'
    redirect_to user_path(current_user)
  end
end

class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  def create
    job = Job.find(params[:job_id])
    current_user.apply(job)
    job.update_attribute(:status, "確認中")
    flash[:success] = '仕事の受託希望を受け付けました。委託会社よりご連絡がありますのでお待ちください。'
    redirect_to root_url
  end

  def destroy
    job = Job.find(params[:job_id])
    current_user.withdraw(job)
    job.update_attribute(:status, "募集中")
    flash[:success] = '受託をキャンセルしました。'
    redirect_to root_url
  end

end

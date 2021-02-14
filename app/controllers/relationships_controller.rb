class RelationshipsController < ApplicationController
  #before_action :require_user_logged_in
  before_action :require_permission
  
  def require_permission
    if logged_in?
    elsif clogged_in?
    else
      redirect_to login_url
    end
  end
  
  def create
    job = Job.find(params[:job_id])
    current_user.apply(job)
    job.update_attribute(:status, "確認中")
    flash[:success] = '仕事の受託希望を受け付けました。委託会社よりご連絡がありますのでお待ちください。'
    redirect_to root_url
  end

  def destroy
    job = Job.find(params[:job_id])
    if logged_in?
      current_user.withdraw(job)
      job.update_attribute(:status, "募集中")
      flash[:success] = '受託をキャンセルしました。'
    elsif clogged_in?
      relationship = Relationship.find_by(job_id: job.id)
      relationship.destroy if relationship
      if job.status == '委託確定'
        flash[:success] = '委託業務が完了しました。'
        job.update_attribute(:status, "完了")
      else
        flash[:success] = '受託を却下しました。'
        job.update_attribute(:status, "募集中")
      end
      
    end
    redirect_to root_url
  end

end

class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    company = Company.find(params[:company_id])
    current_user.follow(company)
    flash[:success] = '企業様をフォローしました。'
    redirect_to corporation_path
  end

  def destroy
    company = Company.find(params[:company_id])
    current_user.unfollow(company)
    flash[:success] = '企業様のフォローを解除しました。'
    redirect_to corporation_path
  end
end

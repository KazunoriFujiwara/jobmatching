class CompaniesController < ApplicationController
  def index
    @companies = Company.order(id: :desc).page(params[:page]).per(25)
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

  private

  def company_params
    params.require(:company).permit(:name, :email, :password, :password_confirmation)
  end
end

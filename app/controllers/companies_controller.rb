class CompaniesController < ApplicationController
  before_action :require_company_clogged_in, only: [:index, :show]
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
    #puts Relationship.find_by(id: 3).user_id
    #array.each do |x|
      #puts x,':'
      #x=Relationship.where(id: i).pluck(:job_id)
      #y=Relationship.where(id: i).pluck(:user_id)
      #puts Relationship.find_by(id: i) #.user_id
      #z=User.where(id: y).pluck(:name)
      #w=Job.where(id: x).pluck(:content)
      #@members.push('受託者名:'+ User.where(id: y).pluck(:name) + ' 委託業務:'+ Job.where(id: x).pluck(:content))
      #puts 'i',i
      #puts 'y',y
      #puts 'x',x
      #puts z
      #puts w
      
      #puts User.where(id: 2).pluck(:name)
    #end
    #@hoge = Kaminari.paginate_array(@memmbers).page(params[:page]).per(4)
  end
  
  
  
  private

  def company_params
    params.require(:company).permit(:name, :email, :password, :password_confirmation)
  end
  
  
end

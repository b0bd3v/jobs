class JobsController < ApplicationController

  def index
    scope = Job.order(created_at: :desc)
    scope = scope.where(status: :published) unless user_signed_in?

    
    render json: scope
  end

  def show
    @job = Job.find(params[:id])
    render json: @job
  end

  def create
    @job = Job.new(job_params)
    
    if @job.save
      render json: @job, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :employment_type, :location, :status)
  end
end

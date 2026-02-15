class JobsController < ApplicationController

  def index
    @jobs = Job.order(created_at: :desc)
    
    render json: @jobs
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

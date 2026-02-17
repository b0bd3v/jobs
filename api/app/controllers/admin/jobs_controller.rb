module Admin
  class JobsController < ApplicationController
    before_action :authenticate_user!

    def index
      scope = Job
      scope = scope.search_by_term(params[:q]) if params[:q].present?
        
      if params[:sort].present?
        column, direction = params[:sort].split(":")
        scope = scope.order(column => direction)
      end

      unless params[:per_page].to_i == -1
        if params[:page].present?
          scope = scope.page(params[:page])
        end

        if params[:per_page].present?
          scope = scope.per(params[:per_page])
        end
      end

      render json: { 
        data: scope.as_json(methods: [:scheduled, :published]), 
        total: scope.total_count 
      }
    end

    def show
      job = Job.find(params[:id])
      render json: job.as_json(methods: [:scheduled, :published])
    end

    def create
      job = Job.new(job_params)
      if job.save
        render json: job.as_json(methods: [:scheduled, :published]), status: :created
      else
        render json: job.errors, status: :unprocessable_entity
      end
    end

    def update
      job = Job.find(params[:id])
      if job.update(job_params)
        render json: job.as_json(methods: [:scheduled, :published])
      else
        render json: job.errors, status: :unprocessable_entity
      end
    end

    def destroy
      job = Job.find(params[:id])
      job.destroy

      render status: :no_content
    end

    private

    def job_params
      params.require(:job).permit(:title, :description, :location, :employment_type, :publish_at)
    end
  end
end
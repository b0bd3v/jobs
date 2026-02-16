module Admin
  class JobsController < ApplicationController
    def index
      scope = Job

      if params[:q].present?
        scope = scope.where("title LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
      end

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

      render json: { data: scope, total: scope.total_count }
    end

    def show
      job = Job.find(params[:id])
      render json: job
    end

    def destroy
      job = Job.find(params[:id])
      job.destroy

      render status: :no_content
    end
  end
end
class JobsController < ApplicationController

  def index
    scope = Job.order(created_at: :desc)
    scope = scope.where(status: :published) unless user_signed_in?
    scope = scope.search_by_term(params[:search]) if params[:search].present?

    jobs = scope.page(params[:page]).per(params[:per_page] || 12)

    render json: {
      jobs: jobs,
      meta: {
        current_page: jobs.current_page,
        next_page: jobs.next_page,
        prev_page: jobs.prev_page,
        total_pages: jobs.total_pages,
        total_count: jobs.total_count
      }
    }
  end

  def show
    @job = Job.find(params[:id])
    render json: @job
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :employment_type, :location, :status)
  end
end

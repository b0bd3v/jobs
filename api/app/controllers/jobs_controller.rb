class JobsController < ApplicationController

  def index
    scope = Job.published
    scope = scope.search_by_term(params[:q]) if params[:q].present?
    scope = scope.where(employment_type: params[:employment_type]) if params[:employment_type].present?
    scope = scope.where(location: params[:location]) if params[:location].present?
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
end

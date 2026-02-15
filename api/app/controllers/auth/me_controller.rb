module Auth
  class MeController < ApplicationController
    before_action :authenticate_user!
    
    def show
      render json: { data: { user: { id: current_user.id, email: current_user.email }}}
    end
  end
end

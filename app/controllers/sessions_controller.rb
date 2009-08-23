class SessionsController < Clearance::SessionsController
  private
    def url_after_create
      user_path current_user
    end
end

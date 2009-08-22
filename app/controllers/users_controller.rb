class UsersController < Clearance::UsersController

  def new
    @user = User.new(params[:user])
    league if params[:league]
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      if params[:league]
        league
        @league.add_player @user
      end
      ::ClearanceMailer.deliver_confirmation @user
      flash_notice_after_create
      redirect_to(url_after_create)
    else
      render :template => 'users/new'
    end
  end
  
  private
    def league
      @league = League.find params[:league]
    end
end

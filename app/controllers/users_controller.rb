class UsersController < Clearance::UsersController

  before_filter :authenticate, :only => [:account, :update]

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def account
    @user    = current_user
    @leagues = @user.leagues
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Successfully updated account.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "account" }
      end
    end
  end

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
    @league ||= League.find params[:league]
  end
end

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

end
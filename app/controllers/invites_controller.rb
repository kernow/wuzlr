class InvitesController < ApplicationController
  
  def new
    league
  end
  
  def create
    league
    params[:emails].each do |email|
      if user = User.find_by_email(email)
        @league.add_player user
      else
        Mailer.deliver_invitation email, @league unless email.blank?
      end
    end
    flash[:sucess] = "Invites have been sent"
    redirect_to league_url(@league)
  end
  
  private
    def league
      @league = League.find(params[:league_id])
    end
end

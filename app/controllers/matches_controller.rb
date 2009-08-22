class MatchesController < ApplicationController

  # GET /leagues/1/matches/1
  def show
    @match = league.matches.find(params[:id])
    @players = league.players

    respond_to do |format|
      format.html {
        case @match.state
        when "playing"  : render :template => "matches/playing"
        else render :template => "matches/result"
        end
      }# show.html.erb
    end
  end

  # GET /leagues/1/matches/new
  def new
    @match   = league.matches.new
    @players = league.players
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # POST /leagues/1/matches
  def create
    @match   = league.matches.create
    @players = league.players
    
    [:red, :blue].each do |t|
      params[t].each do |po,pl|
        next if pl.blank?
        @match.match_players.create(
          :player   => league.players.find(pl.to_i),
          :team     => t.to_s, 
          :position => po.to_i)
      end
    end

    respond_to do |format|
      if @match.kick_off
        flash[:notice] = 'Match was successfully created.'
        format.html { redirect_to league_match_path league, @match }
      else
        @match.destroy
        format.html { render :action => "new" }
      end
    end
  end

  # GET /leagues/1/matches/1/edit
  def full_time
    @match = league.matches.find(params[:id])
    @match.finished_at = Time.now unless @match.finished_at
    @match.full_time
    
    respond_to do |format|
      flash[:notice] = 'Match finished.'
      format.html { redirect_to :action => :edit }
    end
  end
  
  def edit
    @match = league.matches.find(params[:id])
    @players = league.players
    respond_to do |format|
      format.html
    end
  end

  # PUT /leagues/1/matches/1
  def update
    @match = league.matches.find(params[:id])
    @match.attributes = params[:match]
    
    respond_to do |format|
      if @match.record
        flash[:notice] = 'Match was successfully recorded.'
        format.html { redirect_to league_match_path(league, @match) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

private

  def league
    @league ||= League.find(params[:league_id])
  end

end

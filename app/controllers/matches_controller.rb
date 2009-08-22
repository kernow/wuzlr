class MatchesController < ApplicationController

  # GET /leagues/1/matches/1
  def show
    @match = league.matches.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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

  # GET /leagues/1/matches/1/edit
  def edit
    @match = league.matches.find(params[:id])
    @match.finished_at = Time.now unless @match.finished_at
    @match.save
    
    @match = league.matches.find(params[:id])
  end

  # POST /leagues/1/matches
  def create
    @match = league.matches.create
    
    [:red, :blue].each do |t|
      params[t].each do |pl,po|
        @match.match_players.create(
          :player   => league.players.find(pl.to_i),
          :team     => t, 
          :position => po.to_i)
      end
    end

    respond_to do |format|
      if @match.save
        flash[:notice] = 'Match was successfully created.'
        format.html { render :template => "playing" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /leagues/1/matches
  def update
    @match = league.matches.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        flash[:notice] = 'Match was successfully updated.'
        format.html { redirect_to(@match) }
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

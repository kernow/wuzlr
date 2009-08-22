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
    @match = league.matches.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # GET /leagues/1/matches/play
  def play
    @match = league.matches.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /leagues/1/matches/1/edit
  def edit
    @match = league.matches.find(params[:id])
  end

  # POST /leagues/1/matches
  def create
    @match = league.matches.new(params[:match])

    respond_to do |format|
      if @match.save
        flash[:notice] = 'Match was successfully created.'
        format.html { redirect_to(@match) }
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
    @league || League.find(params[:league_id])
  end

end

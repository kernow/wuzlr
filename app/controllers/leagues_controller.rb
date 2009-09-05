class LeaguesController < ApplicationController
  
  before_filter :authenticate, :only => [:new, :create]
  # before_filter :is_owner?, :only => [:edit, :update]
  
  # GET /leagues
  def index
  end
  
  # GET /leagues/1
  def show
    @league     = League.find(params[:id])
    @subheader  = "Current standings"
    @players    = @league.players.find(:all, :order => "users.win_loss_percentage DESC")
    @stats      = @league.stats.find(:all, :order => "win_percent DESC", :include => :user)
    @matches    = @league.matches.find(:all, :conditions => {:state => "recorded"}, :limit => 3, :order => 'finished_at ASC')
    
    fifa_teams = FifaTeam.find(:all, :order => "goals_for DESC")
    @equivalent_teams = case @players.size
    when 0 : nil
    when 1 : [fifa_teams.first]
    else 
      inc = fifa_teams.size / (@players.size - 1)
      Array.new(@players.size){|i| i * inc}.map{|i| fifa_teams[i] } if inc > 0
    end
  end

  # GET /leagues/new
  def new
    @league = League.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  def create
    @league       = League.new(params[:league])
    @league.user  = current_user
    
    respond_to do |format|
      if @league.save
        @league.add_player current_user
        if !!params[:demo_users]
          ["sayhello@petercolesdc.com", "jamie.dyer@jivatechnology.com", "theo.cushion@jivatechnology.com"].each {|e|
            u = User.find_by_email(e)
            puts u.inspect
            @league.add_player u if u
          }
        end        
        flash[:notice] = 'League was successfully created.'
        format.html { redirect_to(@league) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /leagues/1
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        flash[:notice] = 'League was successfully updated.'
        format.html { redirect_to(@league) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end

class LeaguesController < ApplicationController

  # GET /leagues/1
  # GET /leagues/1.xml
  def show
    @leagues = League.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @leagues }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.xml
  def new
    @leagues = League.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @leagues }
    end
  end

  # GET /leagues/1/edit
  def edit
    @leagues = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.xml
  def create
    @leagues = League.new(params[:leagues])

    respond_to do |format|
      if @leagues.save
        flash[:notice] = 'League was successfully created.'
        format.html { redirect_to(@leagues) }
        format.xml  { render :xml => @leagues, :status => :created, :location => @leagues }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @leagues.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.xml
  def update
    @leagues = League.find(params[:id])

    respond_to do |format|
      if @leagues.update_attributes(params[:leagues])
        flash[:notice] = 'League was successfully updated.'
        format.html { redirect_to(@leagues) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @leagues.errors, :status => :unprocessable_entity }
      end
    end
  end

end

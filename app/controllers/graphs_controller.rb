class GraphsController < ApplicationController

  include OpenFlashChartLazy

  def table_bias
    graph = Bar.new("Table Bias")
    red_scores, blue_scores = league.table_bias
    red  = Serie.new(red_scores, {:title=>"Red wins"})
    red.options[:colour] = "#9933CC"
    blue = Serie.new(blue_scores,{:title=>"Blue wins"})
    graph.add_serie(red)
    graph.add_serie(blue)

    graph.y_axis.steps = 5
    graph.y_axis.max = [red_scores, blue_scores].flatten.select{|e| e.is_a? Integer}.max
    
    graph.elements.first[:colour] = "#E45D0B"
    graph.elements.last[:colour]  = "#09A7C9"
    graph.elements.each{|e| e[:type] = "bar_glass" }
    
    graph = style graph
    
    respond_to do |format|
      format.js { render :text => graph.to_graph_json }
    end
  end
  
  def matches_per_day
    results = user? ? user.matches_per_day : league.matches_per_day
    graph   = Line.new("")
    matches = Serie.new(results, {:title => ""})
    
    steps = results.size > 14 ? 7 : 2
    
    matches.labels = matches.labels.map{|l| matches.labels.index(l) % steps == 0 ? Time.parse(l).strftime("%F") : ""}

    graph.y_axis.max = (results.map{|r| r[1] }.max / 5.to_f).ceil * 5
    graph.y_axis.steps = 5    
    graph.x_axis.steps = steps

    graph.add_serie(matches)

    graph.elements.first[:colour] = "#333333"
    graph = style graph

    respond_to do |format|
      format.js { render :text => graph.to_graph_json }
    end

  end

  def form
    graph = Bar.new("Form")

    w     = user.won_per_day
    l     = user.lost_per_day.map{|e| [e[0],e[1] * -1]}
    won   = Serie.new(w, {:title => "Won" })
    lost  = Serie.new(l, {:title => "Lost"})
    
    steps = w.size > 14 ? 7 : 1
    
    lost.labels = lost.labels.map{|a| lost.labels.index(a) % steps == 0 ? Time.parse(a).strftime("%F") : ""}
    
    graph.add_serie(won)
    graph.add_serie(lost)
    
    graph.y_axis.max =  (w + l).map{|e| e[1].abs}.max
    graph.y_axis.min = -(w + l).map{|e| e[1].abs}.max
    graph.x_axis.steps = steps
        
    graph.elements.last[:colour] = "#E45D0B"
    graph.elements.first[:colour]  = "#09A7C9"
    
    graph.elements.each{|e| e[:type] = "bar_glass" }
    
    graph = style graph
    
    respond_to do |format|
      format.js { render :text => graph.to_graph_json }
    end
  end

private
  
  def style(graph)
    graph.bg_colour="#EEEEEE"
    
    graph.x_axis.labels.rotate="vertical"
    graph.x_axis.colour="#808080"
    graph.x_axis["grid-colour"]="#A0A0A0"
    graph.x_axis.stroke=0.5
    
    graph.y_axis.colour="#808080"
    graph.y_axis.stroke=0.5
    graph.y_axis["grid-colour"]="#A0A0A0"
    
    graph.title = nil
    
    # graph.elements.first.text = nil if graph.elements.size == 1
    
    graph
  end

  def user?
    !!params[:user_id]
  end
  
  def league?
    !!params[:league_id]
  end

  def league
    @league ||= League.find(params[:league_id])
  end
  
  def user
    @user ||= User.find(params[:user_id])
  end

end

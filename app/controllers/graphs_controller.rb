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
    graph.x_axis.labels.rotate="vertical"
    graph.y_axis.min = 0
    graph.y_axis.steps = 5
    graph.y_axis.max = [red_scores, blue_scores].flatten.select{|e| e.is_a? Integer}.max
    
    graph.elements.first[:colour] = "#E45D0B"
    graph.elements.last[:colour]  = "#09A7C9"
    graph.bg_colour="#EEEEEE"
    
    respond_to do |format|
      format.js { render :text => graph.to_graph_json }
    end
  end
  
  def matches_per_day
    graph   = Line.new("Matches per Day")
    results = league.matches_per_day
    matches = Serie.new(results, {:title => "Matches per Day"})
    matches.labels = matches.labels.map{|l| Time.parse(l).strftime("%F")}
  
    graph.y_axis.max = (results.map{|r| r[1] }.max / 5.to_f).ceil * 5
    graph.y_axis.steps = 5
    
    graph.add_serie(matches)

    graph.bg_colour="#EEEEEE"
    
    graph.x_axis.labels.rotate="vertical"
    graph.x_axis.colour="#808080"
    graph.x_axis["grid-colour"]="#A0A0A0"
    graph.x_axis.stroke=0.5
    
    graph.y_axis.colour="#808080"
    graph.y_axis.stroke=0.5
    graph.y_axis["grid-colour"]="#A0A0A0"
    
    respond_to do |format|
      format.js { render :text => graph.to_graph_json }
    end
  end

private

  def league
    @league ||= League.find(params[:id])
  end

end

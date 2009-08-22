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
    graph.bg_colour="#FFFFFF"
    
    respond_to do |format|
      format.js { render :text => graph.to_graph_json }
    end
  end

private

  def league
    @league ||= League.find(params[:id])
  end

end

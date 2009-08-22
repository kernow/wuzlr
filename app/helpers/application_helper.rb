# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def win_loss_bar(user, options={})
    content_tag :div, :class => options[:class], :style => "width:#{user.win_loss_percentage_i}px" do
      "#{user.win_loss_percentage_i}%"
    end
  end
end

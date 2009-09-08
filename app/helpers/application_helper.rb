# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def win_loss_bar(user, options={})
    content_tag :div, :class => options[:class], :style => "width:#{user.win_loss_percentage_i}%" do
      "#{user.win_loss_percentage_i}%"
    end
  end
  
  def gravatar_for_with_default(user, options={})
    options = { :default => 'wavatar' }.merge options
    gravatar_for user, options
  end
  
  def team_flag_image_for(player, position, total_players, teams)
    team = case
      when position == 0
        logger.info "team numnber: first"
        teams.first
      when position == total_players - 1
        logger.info "team numnber: last"
        teams.last
      else
        inc = (teams.size / (total_players - 1)).floor
        logger.info "team number: #{inc * position}"
        teams[inc * position]
    end
    image_tag team[:flag], :title => team[:name]
  end
end

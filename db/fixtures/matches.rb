User.find(:all).each{|player|
  player.leagues.each{|league|
    started_playing = (rand(360) + 5).days.ago
    number_matches  = rand(10) + 1
    min_game_time   = 30
    max_game_time   = 15 * 60
    
    number_matches.times {
      match = league.matches.create
      
      possible_players = league.players.sort{rand(2) -1}
      players          = [possible_players.delete(player)]
      [1,3].rand.times {
        players << possible_players.pop
      }
      
      (players.size / 2).times {|i|
        match.match_players.create(
          :player   => players.pop,
          :team     => "red", 
          :position => i + 1)
        match.match_players.create(
          :player   => players.pop,
          :team     => "blue", 
          :position => i + 1)
      }
                    
      game_start     = Time.at(rand(Time.now.to_i - started_playing.to_i) + started_playing.to_i)
      game_length    = Time.at(rand(max_game_time - min_game_time) + min_game_time)
      game_finish    = Time.at(game_start.to_i + game_length.to_i)
      
      match.created_at  = game_start
      raise match.errors.full_messages unless match.kick_off
      match.finished_at = game_finish
      raise match.errors.full_messages unless match.full_time 
      
      case ['red', 'blue'].rand
      when "red"
        match.red_score  = 10
        match.blue_score = rand(10)
      when "blue"
        match.blue_score = 10
        match.red_score  = rand(10)
      end
      
      raise match.errors.full_messages unless match.record
      
      puts " - Match {:players => [#{match.players.map{|p| p.name}.join(', ')}]}"
    }
  }

  
}
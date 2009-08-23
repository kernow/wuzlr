matches = []
time            = Time.now
started_playing = 1.month.ago
min_game_time   = 30
max_game_time   = 15 * 60

1000.times {
  game_start     = Time.at(time.to_i - rand(time - started_playing).to_i)
  game_length    = rand(max_game_time - min_game_time) + min_game_time
  game_finish    = Time.at(game_start.to_i + game_length)
    
  matches << {:game_start => game_start , :game_finish => game_finish}
}

matches.sort_by{|e| e[:game_start]}.each{|m|
  league = League.find(:first, :order => 'rand()')
  match  = league.matches.create
  
  possible_players = league.players.dup
  players          = []
  [2,4].rand.times {
    players << possible_players.delete(possible_players.rand)
  }
  
  players.flatten!
  (players.size/2).times {|i|
    match.match_players.create!(
      :player   => players.pop,
      :team     => "red", 
      :position => i + 1)
    match.match_players.create!(
      :player   => players.pop,
      :team     => "blue", 
      :position => i + 1)
  }
  
  match.started_at  = m[:game_start]
  raise match.errors.full_messages unless match.kick_off
  match.finished_at = m[:game_finish]
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
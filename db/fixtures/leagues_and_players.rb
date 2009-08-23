{
"Premier League"=> [
  "Gary Speed", "David James", "Ryan Giggs", "Alan Shearer", "Gareth Southgate", "Sol Campbell", "Teddy Sheringham", "Andrew Cole", "Ray Parlour", "Emile Heskey", "Robbie Fowler", "Nigel Martyn", "Frank Lampard", "Paul Scholes", "Roy Keane", "David Unsworth", "Gary Neville", "Chris Perry", "Trevor Sinclair", "Ugo Ehiogu", "Nigel Winterburn"],

"The Football League" => [
  "Billy Bassett", "Archie Hunter", "John Goodall", "Steve Bloomer", "Billy Meredith", "Bob Crompton", "William Foulke", "Alf Common", "Sam Hardy", "Bill McCracken", "Viv Woodward", "Clem Stephenson", "Charles Buchan", "Elisha Scott", "Dixie Dean", "George Camsell", "Hughie Gallacher", "Harry Hibbs", "Alex James", "Eddie Hapgood"],

"Football Conference" => [
  "Andrew Mangan", "James Constable", "Steve Morison", "Charlie Griffin", "Matthew Barnes-Homer", "Jack Midson", "Greg Pearson", "Colin Little", "Justin Richards", "Shaun Harrad", "Jefferson Louis", "Gareth Seddon", "Richard Brodie"
]
}.each{|league, players|
  players.each do |p|
    User.seed(:name) do |s|
      s.name                  = p
      s.email                 = p.gsub(" ",".").downcase + "@jivatechnology.com"
      s.password              = "foofoo"
      s.password_confirmation = "foofoo"
      s.email_confirmed       = true
    end
    
    u = User.find_by_name p
    
    League.seed(:name) do |s|
      s.name = league
      s.user = u
    end

    l = League.find_by_name league
    
    l.players << u unless l.players.include?(p)
  end
  
}



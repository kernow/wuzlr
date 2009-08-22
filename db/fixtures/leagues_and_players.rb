{
"Premier League"=> [
  "Gary Speed", "David James", "Ryan Giggs", "Alan Shearer", "Gareth Southgate", "Sol Campbell", "Teddy Sheringham", "Andrew Cole", "Ray Parlour", "Emile Heskey", "Robbie Fowler", "Nigel Martyn", "Frank Lampard", "Paul Scholes", "Roy Keane", "David Unsworth", "Gary Neville", "Chris Perry", "Trevor Sinclair", "Ugo Ehiogu", "Nigel Winterburn", "Les Ferdinand", "Steve Watson", "Dwight Yorke", "David Seaman", "Nicky Butt", "Tim Sherwood", "Kenny Cunningham", "Rio Ferdinand", "Philip Neville", "Jason Dodd", "Denis Irwin", "Graeme Le Saux", "Kevin Campbell", "Jamie Carragher", "Gary Kelly", "Gary McAllister", "Martin Keown", "Darren Anderton", "Peter Atherton", "Robbie Savage", "Paul Telfer", "Dennis Bergkamp", "Shay Given", "Lee Bowyer", "Dion Dublin", "Ian Walker", "Peter Schmeichel", "Paul Ince", "Lee Dixon", "Alan Wright", "Nick Barmby", "Garry Flitcroft"],

"The Football League" => [
  "Billy Bassett", "Archie Hunter", "John Goodall", "Steve Bloomer", "Billy Meredith", "Bob Crompton", "William Foulke", "Alf Common", "Sam Hardy", "Bill McCracken", "Viv Woodward", "Clem Stephenson", "Charles Buchan", "Elisha Scott", "Dixie Dean", "George Camsell", "Hughie Gallacher", "Harry Hibbs", "Alex James", "Eddie Hapgood", "Cliff Bastin", "Wilf Copping", "David Jack", "Stanley Matthews", "Ted Drake", "Joe Mercer", "Raich Carter", "Peter Doherty", "Frank Swift", "Tommy Lawton", "Wilf Mannion", "George Hardwick", "Johnny Carey", "Stan Mortensen", "Neil Franklin", "Trevor Ford", "Nat Lofthouse", "Tom Finney", "Alf Ramsey", "Len Shackleton", "Jimmy Dickinson", "Arthur Rowley", "Billy Liddell", "Billy Wright", "Jackie Milburn", "John Charles", "Ivor Allchurch", "Danny Blanchflower", "Bert Trautmann", "Jimmy McIlroy", "Tommy Taylor", "Cliff Jones"],

"Football Conference" => [
  "Andrew Mangan", "James Constable", "Steve Morison", "Charlie Griffin", "Matthew Barnes-Homer", "Jack Midson", "Greg Pearson", "Colin Little", "Justin Richards", "Shaun Harrad", "Jefferson Louis", "Gareth Seddon", "Richard Brodie"
]
}.each{|league, players|
  League.seed(:name) do |s|
    s.name = league
  end
  
  l = League.find_by_name league
  
  players.each do |p|
    User.seed(:name) do |s|
      s.name                  = p
      s.email                 = p.gsub(" ",".").downcase + "@jivatechnology.com"
      s.password              = "foofoo"
      s.password_confirmation = "foofoo"
      s.email_confirmed       = true
    end
    
    u = User.find_by_name p
    
    l.players << u unless l.players.include?(p)
  end
  
}



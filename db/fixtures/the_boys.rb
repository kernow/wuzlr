User.seed(:name) do |s|
  s.name                  = "Theo"
  s.email                 = "theo@jivatechnology.com"
  s.password              = "foofoo"
  s.password_confirmation = "foofoo"
  s.email_confirmed       = true
end

u = User.find_by_email "theo@jivatechnology.com"
  
League.seed(:name) do |s|
  s.name        = "Jiva!"
  s.description = "Taking table football to new lows"
  s.user        = u
end

l = League.find_by_name "Jiva!"

{"Jamie" => "jamie@jivatechnology.com", "Peter" => "petercolesdc@gmail.com", "Nic" => "nicolas.alpi@gmail.com", "Theo" => "theo.cushion@jivatechnology.com", "Jamie" => "jamie.dyer@jivatechnology.com", "Peter" => "sayhello@petercolesdc.com"}.each{|name,email|
  User.seed(:name) do |s|
    s.name                  = name
    s.email                 = email
    s.password              = "foofoo"
    s.password_confirmation = "foofoo"
    s.email_confirmed       = true
  end
  
  u = User.find_by_email email
  
  l.players << u unless l.players.include?(u)
}


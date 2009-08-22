class Mailer < ActionMailer::Base
  
  default_url_options[:host] = HOST
  
  def invitation(to, league)
    from       DO_NOT_REPLY
    recipients to
    subject    "You have been summoned to Wuzlr!"
    body       :league => league
  end
  
end
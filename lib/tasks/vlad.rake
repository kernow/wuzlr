begin
  require 'vlad'
  require 'hoe'
  
  Vlad.load :app => :passenger, :scm => :git
rescue LoadError
  # do nothing
end
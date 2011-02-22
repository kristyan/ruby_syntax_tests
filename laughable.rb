
module Laughable
  def self.included(mod)
     puts "#{self} included in #{mod}"
     mod.extend ClassMethods
  end  
  
  def laugh
    puts "HA HA HA"
  end
  
  module ClassMethods
    def laugh_more
      puts "HA HA HA HA HA HA"
    end
  end  
end  


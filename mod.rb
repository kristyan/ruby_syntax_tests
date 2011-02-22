module Test
  puts "Loading test"
  def self.included(base)
    base.extend(ClassMethods)
    puts "test was included..............++++"
  end
  
  def testmod()
    puts "calling testmod"
  end

  def self.class_func()
    puts "calling class func +++++++"
  end

  module ClassMethods
    
    def class_func()
      puts "calling class func +++++++"
    end
    
    def class_func2()
       puts "calling class func 2 +++++++"    
    end
  end 
end

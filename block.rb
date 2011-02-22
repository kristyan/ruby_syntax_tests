puts "loading........."
require "mod"
puts "loading...."
puts self.class
def yielder(&block)
  yield
  block.call
end

def test
  val = 1
  yielder do
    puts "in block...val = #{val}"
  end
end


module Outer
  class Kris
    include Test
    def hello
      puts "hello"
    end

    def method_missing(method_name, *args, &block)
      puts "args type = " + args.class.to_s
      puts "hello #{method_name} args = #{args}"
    end

    class << self
      def method_missing(method_name, *args, &block)
        puts "hello #{method_name} args = #{args}"
        puts "args type = " + args.class.to_s
      end
    end

    ["a","b","c"].each do |v|
      define_method(v) do
        puts "this is #{v} called "
      end  
    end
  
    ["d","e","f"].each do |v|   
       code = "def #{v}();puts 'this is #{v} called.';end"
       class_eval code 
    end
    
   ["g","h","i"].each do |v| 
     code =<<-METHOD
       def #{v}()
         puts 'this is #{v} called.........'
       end
     METHOD
     class_eval code
   end
   
     
  end
end

k = Outer::Kris.new
k.hello
k.test
k.testmod
k.a
k.b
k.c
k.e
k.f
k.g
k.h
k.i
k.tryit "A","b","v"
Outer::Kris.jjjjj 1,"de"
Outer::Kris.ttt
Outer::Kris.class_func
Outer::Kris.class_func2


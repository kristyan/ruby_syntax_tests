class Funcs
  attr_accessor :inner
  
  def initialize()
     # note the self here otherwise inner will be take to be a local var
     self.inner = "cool stuff"
  end  
  
  def func(*args)
     puts args.size
     puts args
  end  

  def func2(args)
      args.each{|a| puts "a = #{a}"}  
  end

  def func3(arg1, *other, hash, &block)
    puts "arg1 = #{arg1}"
    hash.each{|a| puts "a = #{a}"} 
    puts other
    
    # evaluate the block in context of instance (How do I pass the param)
    instance_eval &block
    
    # this wont work as class_eval is defined on class Class not on Object
    #class_eval &block     
  end
  
  def func4(arg1, *other, hash, &block)
    puts "arg1 = #{arg1}"
    hash.each{|a| puts "a = #{a}"} 
    puts other
    if block_given?
      yield self
    end
  end
  
  def say_hello
    puts "Hello mate inside"
  end
  
  class_eval do
    def say_goodbye
       puts "Goodbye mate"
    end
  end 
  
  instance_eval do
    def dynamic3
      puts "Calling dynamic 3"
    end
  end 
  
  def method_missing(sym, *args, &block)
     puts "method #{sym} missing with args = #{args}"  
  end  
end    


Funcs.class_eval do
  def dynamic
    puts "Calling dynamic"
  end
end

Funcs.instance_eval do
  def dynamic2
    puts "Calling dynamic 2"
  end   
end  

# class reopening (monkey patching)
class Funcs
  def monkey
    puts "monkey called"
  end
end  

funcs = Funcs.new

funcs.func(1,2,4,5,6, "hello", :again)

funcs.func2 :a => "one", :b => "two", :c => "three"

funcs.func3 :foo, :bar, :test, :a => "one", :b => "two", :c => "three" do 
   puts "Self is: #{self}"
   say_hello
   dynamic
   say_goodbye
   # this block has direct access to instance data as it was called in the context of the instance 
   puts "inner 1 = #{@inner}"
end  

funcs.func4 :foo, :bar, :test, :a => "one", :b => "two", :c => "three" do |f|
   puts "calling block with #{f}"
   puts "Self is: #{self}"
   f.say_hello
   f.dynamic
   # this wont work
   #puts "inner 2 = #{@inner}"
   # this does- # this block has no direct access to instance data as it was not called in the context of the instance , but in the context of Object:main
   puts "inner 2 = #{f.inner}"
end

# note the hash has to be the last non block param
funcs.blah(1, :cool, :a => "kris", :b => "john")

funcs.monkey

# call some class methods
Funcs.dynamic2
Funcs.dynamic3

# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class ThreadTest
  attr_reader :run
  attr_writer :run
  
  def initialize
    @run = true
  end
  
  def process
    while @run
      puts "hahahahahahahah"
    end
  end
end

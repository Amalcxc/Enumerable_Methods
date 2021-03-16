module Enumerable
  def my_each
    # your code here
    i = 0
    #last_arr = self.length -1
    while i < self.length 
      yield(self[i])
      i += 1 
    end  
  end
end

["A","b","A","b","A","b"].my_each{|a| puts a}

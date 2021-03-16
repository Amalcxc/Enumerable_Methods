module Enumerable
  def my_each
    i = 0
    while i < self.length 
      yield(self[i])
      i += 1 
    end  
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end

end

["A","b","A","b","A","b"].my_each{|a| puts a}

["A","b","A","b","A","b"].my_each_with_index{
  |num| puts "#{num} -> #{i = 'potato' if i > 2}"
}

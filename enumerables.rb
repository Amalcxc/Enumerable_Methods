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

  def my_select
    i = 0
    fliter = []
    while i < self.length
      fliter.push(self[i]) if yield(self[i])
      i += 1
    end
    fliter
  end

  def my_all?
    final_bool = true
    self.my_each { |n| final_bool = false if !yield(n) }

    final_bool
  end

  def my_any?
    final_bool = false
    self.my_each { |n| final_bool = true if yield(n) }

    final_bool
  end

  def my_none?
    final_bool = true
    self.my_each { |n| final_bool = false if yield(n) }
    
    final_bool
  end

end

["A","b","A","b","A","b"].my_each{|a| puts a}

["A","b","A","b","A","b"].my_each_with_index{
  |num| puts "#{num} -> #{i = 'potato' if i > 2}"}

["A","b","A","john","A","b"].my_select{
  |person| person != "john"}

  ["foiiur", "fiiive", "sixsix", "seveeen"].my_all? { |a| a.length > 5 }

["fr", "fiiive", "sixsix", "seveeen"].my_any? { |a| a.length > 5 }

["fix", "emmm", "wdss22", "ssss"].my_none? { |a| a.length > 5 }







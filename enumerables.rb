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

  def my_count(*args)
    counter = 0
    if (args.empty?)
      self.my_each { |to_count| counter += 1 }
    else
      self.my_each { |to_count| counter += 1 if args[0] == to_count}
    end

    counter
  end
  
  def my_map
    result = []
    self.my_each { |n| result.push(yield(n)) }
    result

  end

  def my_inject(*args)
    result = nil
    symbol = nil

    case args.length
    when 1
      if args[0].is_a?(Symbol) || args[0].is_a?(String)
        symbol = args[0]
      else
        result = args[0]
      end

    when 2
      result = args[0]
      symbol = args[1]

    end

    if block_given? && symbol.nil?
      self.my_each { |x| result = yield(result, x) }

    else
      self.my_each { |x| result = result.nil? ? x : result.send(symbol, x) }

    end
    return result
  end  

end

#puts [1,2,3,4,10].my_inject(3){|sum, number| sum + number}

#puts [2, 20, 5].my_inject(:*)
puts [3, 6, 10].my_inject(0) {|sum, number| sum + number}

#puts :+.is_a?(String)

#puts [2, 20, 5].my_inject(2, {|num| num.+})



=begin
["A","b","A","b","A","b"].my_each{|a| puts a}

["A","b","A","b","A","b"].my_each_with_index{
  |num| puts "#{num} -> #{i = 'potato' if i > 2}"}

["A","b","A","john","A","b"].my_select{
  |person| person != "john"}

  ["foiiur", "fiiive", "sixsix", "seveeen"].my_all? { |a| a.length > 5 }

["fr", "fiiive", "sixsix", "seveeen"].my_any? { |a| a.length > 5 }

["fix", "emmm", "wdss22", "ssss"].my_none? { |a| a.length > 5 }

puts [1, 1, 1, 4, nil, nil].my_count(1, 2, 3)

arr_a = %w[a b c d e f]
puts arr_a.my_map { |a| a * 2 }
=end








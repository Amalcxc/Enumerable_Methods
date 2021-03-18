# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
  # 1 - my_each ==================================
  def my_each
    return enum_for(:my_each) unless block_given?

    arr = to_a.flatten

    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end

    self
  end

  # 4 - my_all? ==================================
  def my_all?(param = nil)
    if block_given?
      to_a.my_each { |n| return false unless yield(n) }

    elsif param.nil?
      to_a.my_each { |n| return false if !n || n.nil? }

    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |n| return false unless [n.class, n.class.superclass, n.class.superclass].include?(param) }

    elsif !param.nil? && (param.is_a? Regexp)
      to_a.my_each { |n| return false unless n.match(param) }

    else
      to_a.my_each { |n| return false unless n == param }
    end

    true
  end

  # 5 - my_any? ==================================
  def my_any?(param = nil)
    if block_given?
      to_a.my_each { |n| return true if yield(n) }

    elsif param.nil?
      to_a.my_each { |n| return true if n }

    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |n| return true if [n.class, n.class.superclass, n.class.superclass].include?(param) }

    elsif !param.nil? && (param.is_a? Regexp)
      to_a.my_each { |n| return true if n.match(param) }

    else
      to_a.my_each { |n| return true if n == param }
    end

    false
  end

  # 6 - my_none? =================================
  def my_none?(param = nil)
    if block_given?
      my_each { |n| return false if yield(n) }

    elsif param.nil?
      to_a.my_each { |n| return false if n }

    elsif !param.nil? && (param.is_a? Class)
      my_each { |n| return false if [n.class, n.class.superclass, n.class.superclass].include?(param) }

    elsif !param.nil? && (param.is_a? Regexp)
      my_each { |n| return false if n.match(param) }

    else
      my_each { |n| return false if n == param }

    end

    true
  end

  # 7 - my_count =================================
  def my_count(param = nil)
    counter = 0
    if block_given?
      my_each { |n| counter += 1 if yield(n) }

    elsif param.nil?
      my_each { |_n| counter += 1 }
    else
      my_each { |n| counter += 1 if n == param }

    end

    counter
  end

  # 8 - my_map ==================================
  def my_map()
    return enum_for(:my_map) unless block_given?

    arr = []
    to_a.my_each { |n| arr.push(yield(n)) }

    arr
  end

  # 9 - my_inject ================================
  def my_inject(result = nil, symbol = nil)
    if !block_given? && symbol.nil?
      symbol = result
      result = nil
    end

    arr = to_a.flatten

    if block_given?
      arr.my_each { |n| result = result.nil? ? n : yield(result, n) }

    elsif symbol.is_a? Symbol
      arr.my_each { |n| result = result.nil? ? n : result.send(symbol, n) }

    end

    result
  end
end

module Enumerable
  # 2 - my_each_with_idex ===========================
  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    arr = to_a.flatten

    i = 0
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end

    self
  end

  # 3 - my_select ================================
  def my_select
    return enum_for(:my_select) unless block_given?

    arr = to_a.flatten

    i = 0
    selected = []
    while i < arr.length
      selected.push(arr[i]) if yield(arr[i])
      i += 1
    end
    selected
  end
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

def multiply_els(arr)
  arr.my_inject(:*)
end

# 1 - my_each ==================================================
puts "\n=======================\n1 - my_each\n======================="
%w[how are you doing].my_each { |n| puts n }
{ 'key1' => { link: 'index/all', size: 666 } }.my_each { |n| puts n }

# 2 - my_each_with_index =======================================
puts "\n=======================\n2 - my_each_with_index\n======================="
hash = {}
(%w[cat dog wombat].each_with_index { |item, index| hash[item] = index })
puts hash #=> {"cat"=>0, "dog"=>1, "wombat"=>2}

(%w[A b A b A b].my_each_with_index do |num, i|
  puts "#{num} -> #{i > 2 ? 'potato' : 'po'}"
end)

# 3 - my_select ================================================
puts "\n=======================\n3 - my_select\n======================="
puts ((1..10).my_select { |i| (i % 3).zero? }).to_s #=> [3, 6, 9]
puts [1, 2, 3, 4, 5].my_select(&:even?).to_s #=> [2, 4]
puts (%i[foo bar].my_select { |x| x == :foo }).to_s #=> [:foo]

# 4 - my_all? ==================================================
puts "\n=======================\n4 - my_all?\n======================="
puts(%w[ant bear cat].my_all? { |word| word.length >= 3 }) #=> true
puts(%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
puts(%w[ant bear cat].my_all?(/t/)) #=> false
puts [1, 2, 3.14].my_all?(Numeric) #=> true
puts [nil, true, 99].my_all? #=> false
puts [].all? #=> true

# 5 - my_any? ==================================================
puts "\n=======================\n5 - my_any?\n======================="
puts(%w[ant bear cat].my_any? { |word| word.length >= 3 }) #=> true
puts(%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
puts(%w[ant bear cat].my_any?(/d/)) #=> false
puts [nil, true, 99].my_any?(Integer) #=> true
puts [nil, true, 99].my_any? #=> true
puts [].my_any? #=> false

# 6 - my_none ==================================================
puts "\n=======================\n6 - my_none\n======================="
puts(%w[ant bear cat].my_none? { |word| word.length == 5 }) #=> true
puts(%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
puts(%w[ant bear cat].my_none?(/d/)) #=> true
puts [1, 3.14, 42].my_none?(Float) #=> false
puts [].my_none? #=> true
puts [nil].my_none? #=> true
puts [nil, false].my_none? #=> true
puts [nil, false, true].my_none? #=> false

# 7 - my_count =================================================
puts "\n=======================\n7 - my_count\n======================="
arr_count = [1, 2, 4, 2]
puts arr_count.my_count #=> 4
puts arr_count.my_count(2) #=> 2
puts arr_count.my_count(&:even?) #=> 3

# 8 - my_map ===================================================
puts "\n=======================\n8 - my_map\n======================="
factor = proc { |n| n * 2 }
puts [2, 3, 4].my_map(&factor).to_s #=> [4, 6, 8]
puts ([2, 3, 4].my_map(&factor).my_map { |n| n * 3 }).to_s #=> [12, 18, 24]
puts ((1..4).my_map { |i| i * i }).to_s #=> [1, 4, 9, 16]

# 9 - my_inject ================================================
puts "\n=======================\n9 - my_inject\n======================="
puts ((5..10).my_inject { |sum, n| sum + n }).to_s #=> 45
puts ((5..10).my_inject(1) { |product, n| product * n }).to_s #=> 151200
puts(%w[cat sheep bear].my_inject { |memo, word| memo.length > word.length ? memo : word }) #=> "sheep"
puts [2, 20, 5].my_inject(:*) #=> 200
puts [2, 20, 5].my_inject(:+) #=> 27
puts [3, 6, 10].my_inject(0) { |sum, number| sum + number } #=> 19

# 10 - my_multiply_els =========================================
puts "\n=======================\n9 - my_multiply_els\n======================="
puts multiply_els([2, 3, 4, 5]).to_s #=> 120

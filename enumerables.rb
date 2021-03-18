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

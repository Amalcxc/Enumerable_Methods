module Enumerable
  def my_each
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    i = 0
    fliter = []
    while i < length
      fliter.push(self[i]) if yield(self[i])
      i += 1
    end
    fliter
  end

  def my_all?
    final_bool = true
    my_each { |n| final_bool = false unless yield(n) }

    final_bool
  end

  def my_any?
    final_bool = false
    my_each { |n| final_bool = true if yield(n) }

    final_bool
  end

  def my_none?
    final_bool = true
    my_each { |n| final_bool = false if yield(n) }

    final_bool
  end

  def my_count(*args)
    counter = 0
    if args.empty?
      my_each { |_to_count| counter += 1 }
    else
      my_each { |to_count| counter += 1 if args[0] == to_count }
    end

    counter
  end

  def my_map(&block)
    result = []
    my_each { |n| block.call(result.push(yield(n))) }
    result
  end

  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
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
      my_each { |x| result = yield(result, x) }

    else
      my_each { |x| result = result.nil? ? x : result.send(symbol, x) }

    end
    result
  end
  # rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
end

def multiply_els(arr)
  arr.my_inject(:*)
end

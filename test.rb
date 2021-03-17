require_relative 'enumerables'

# my_each
puts :+.is_a?(String)
%w[A b A b A b].my_each { |a| puts a }

# my_each_with_index
%w[A b A b A b].my_each_with_index do |num, i|
  puts "#{num} -> #{'potato' if i > 2}"
end

# my_select
%w[A b A john A b].my_select do |person|
  person != 'john'
end

# my_all
%w[foiiur fiiive sixsix seveeen].my_all? { |a| a.length > 5 }

# my_any
%w[fr fiiive sixsix seveeen].my_any? { |a| a.length > 5 }

# my_none
%w[fix emmm wdss22 ssss].my_none? { |a| a.length > 5 }

# my_count
puts [1, 1, 1, 4, nil, nil].my_count(1, 2, 3)

# my_map
factor = proc { |n| n * 2 }
puts [2, 3, 4].my_map(&factor)
puts ([1, 2].my_map { |n| n * 2 }).to_s

# my_inject
puts [2, 20, 5].my_inject(:*)
puts [3, 6, 10].my_inject(0) { |sum, number| sum + number }

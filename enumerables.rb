module Enumerable
  def my_each
    i = 0
    while i < length
      yield (self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    selected = []
    my_each { |i| selected << i if yield(i) }
    selected
  end

  def my_all?
    result = true
    my_each { |i| result = false unless yield(i) }
    result
  end

  def my_any?
    result = false
    my_each { |i| result = true if yield(i) }
    result
  end

  def my_none?(var = nil)
    result = true
    my_each do |item|
      if block_given?
        return result = false if yield(item)
      elsif var.nil?
        return result = false if item
      else
        return result = false if var === item
      end
    end
    result
  end
    
    
  def my_count(*args, &block)
    if args.length == 1 && !block_given?
      # use args[0]
      j = 0
      for i in 0..self.length
       if args[0] == self[i] 
         j += 1
       end
      end
      j
    elsif args.length == 1 && block_given?
      # use block
      j = 0
      for i in 0..self.length
        if yield(i)
          j += 1
        end
      end
      j
    elsif args.length == 0 && !block_given?
      # no argument/block
      for i in 0..self.length
      end
      i
    elsif args.length == 0 && block_given?
      #use block
      j = 0
      for i in 0..self.length
        if yield(i)
          j += 1
        end
      end
      j
    else
      # raise error
      "Error"
    end
  end

  def my_map(arr = nil)
    result = []
    if arr.nil?
      my_each { |i| result.push(yield(i)) }
    else
      my_each { |i| result.push result.call(i) }
    end
    result
  end

  def my_inject
    result = first
    each_with_index do |item, index|
      next if index.zero?

      result = yield(result, item)
    end
    result
  end

  def multiply_els
    my_inject { |total, item| total * item }
  end
end

# test my_each method
puts # just to skip a line
print 'Test My Each'
puts
p [1, 2, 3, 4, 5].my_each {|item| item * 2}
p [1,2,3,4,5].each {|x| x * 2}
p [1,2,3,4,5].each
puts # just to skip a line

# test my_each_with_index method
puts # just to skip a line
print 'Test My Each With Index'
puts
#puts([1, 2, 3, 4, 5].my_each_with_index { |item, index| puts "Element #{item} with index #{index}" })
puts # just to skip a line

puts # just to skip a line
print 'Test My Select'
puts
p (0..5).select{|x| x.even?}
#puts([1, 2, 3, 4, 2, 5].my_select { |item| item == 2 })

puts # just to skip a line

puts # just to skip a line
print 'Test My All'
puts
#p([2, 2, 2, 2, 2, 2].my_all? { |item| item == 2 }) # true
#p([6, 5, 4, 3, 2, 1].my_all? { |item| item == 2 }) # false
#p([].my_all? { |item| item == 2 }) # true
puts # just to skip a line

puts # just to skip a line
print 'Test My Any'
puts
p([2, 2, 2, 2, 2, 2].my_any? { |item| item == 2 }) # true
p([6, 5, 4, 3, 2, 1].my_any? { |item| item == 2 }) # false
p([].my_any? { |item| item == 2 }) # true
puts # just to skip a line

puts # just to skip a line
print 'Test My None'
puts
p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p %w{ant bear cat}.my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false
puts # just to skip a line

puts
print 'Test My Map'
puts
p([1, 2, 3, 4, 5, 2, 2, 1].my_map { |item| item * 2 })
puts # just to skip a line

# test my_inject method
print 'Test My Inject'
puts
puts([1, 2, 3, 4, 5, 2, 2, 1].my_inject { |total, element| total + element })
puts # just to skip a line

print 'Test Multiply ELS'
puts
puts([2, 4, 5].multiply_els)

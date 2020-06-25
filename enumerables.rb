module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield (self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    selected = []
    self.my_each { |i| selected << i unless !yield(i) }
    selected
  end

  def my_all?
    result = true
    self.my_each { |i| result = false unless yield(i) }
    result
  end

  def my_any?
    result = false
    self.my_each { |i| result = true if yield(i) }
    result
  end

  def my_none?
    result = true
    self.my_each { |i| result = false if yield(i) }
    result
  end

  def my_count
    result = 0
    self.my_each { |i| result += 1 if yield(i) }
    result
  end

  def my_map (arr = nil)
    if arr == nil
      result = []
      self.my_each { |i| result.push(yield(i)) }
      result
    else
      result = []
      self.my_each { |i| result.push result.call(i) }
      result
    end
  end

  def my_inject
    result = self.first
    self.each_with_index do | item, index |
        next if index == 0
        result = yield(result, item)
    end
    result
  end

  def multiply_els
    self.my_inject { |total, item| total * item }
  end
end

# test my_each method
puts #just to skip a line
print "Test My Each"
puts
[1, 2, 3, 4, 5].my_each { | item | puts item * 2 }
puts #just to skip a line

# test my_each_with_index method
puts #just to skip a line
print "Test My Each With Index"
puts
[1, 2, 3, 4, 5].my_each_with_index { | item, index | puts "Element #{item} with index #{index}" }
puts #just to skip a line

puts #just to skip a line
print "Test My Select"
puts
print [1, 2, 3, 4, 2, 5].my_select { | item | item == 2 }
puts #just to skip a line

puts #just to skip a line
print "Test My All"
puts
puts [2, 2, 2, 2, 2, 2].my_all? { | item | item == 2 }  #true
puts [6, 5, 4, 3, 2, 1].my_all? { | item | item == 2 }  #false
puts [].my_all? { | item | item == 2 }  #true
puts #just to skip a line

puts #just to skip a line
print "Test My Any"
puts
puts [2, 2, 2, 2, 2, 2].my_any? { | item | item == 2 }  #true
puts [6, 5, 4, 3, 2, 1].my_any? { | item | item == 2 }  #false
puts [].my_any? { | item | item == 2 }  #true
puts #just to skip a line

puts #just to skip a line
print "Test My None"
puts
puts [2, 2, 2, 2, 2, 2].my_none? { | item | item == 2 }  #false
puts [6, 5, 4, 3, 2, 1].my_none? { | item | item == 2 }  #false
puts [].my_none? { | item | item == 2 }  #true
puts #just to skip a line

puts
print "Test My Count"
puts
puts [1, 2, 3, 4, 5, 2, 2, 1].my_count { | item | item == 2 }
puts #just to skip a line
#count() = 8
#count(2) = 3
#count(1) = 2
#count(4) = 1

puts
print "Test My Map"
puts
puts [1, 2, 3, 4, 5, 2, 2, 1].my_map { | item | item * 2 }
puts #just to skip a line

print "Test My Inject"
puts #just to skip a line

#test my_inject method
puts [1, 2, 3, 4, 5, 2, 2, 1].my_inject { | total, element | total + element }
puts #just to skip a line

print "Test Multiply ELS"
puts
puts [2, 4, 5].multiply_els

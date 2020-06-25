module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield (self[i])
      i += 1
    end
  end

  def my_each_with_index
  end

  def my_select
  end

  def my_all?
  end

  def my_any?
  end

  def my_none?
  end

  def my_count
  end

  def my_map
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

print "Test My Inject"
puts #just to skip a line

#test my_inject method
puts [1, 2, 3, 4, 5].my_inject { | total, element | total + element }
puts #just to skip a line

print "Test Multiply ELS"
puts
puts [2, 4, 5].multiply_els

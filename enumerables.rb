module Enumerable
  def my_each
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
  end
end

#test my_inject method
puts [1, 2, 3, 4, 5].my_inject { | total, element | total + element }
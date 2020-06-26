module Enumerable
  def my_each(var = nil)
    return to_enum unless block_given?

    i = var
    if var.nil?
      i = 0
    else
      i = var
    end
    
    while i < size
      yield(to_a[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(to_a[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    selected = []
    my_each { |i| selected << i if yield(i) }
    selected
  end

  def my_all?(var = nil)
    result = true
    my_each do |item|
      if block_given?
        return result = false unless yield(item)
      elsif var.nil?
        return result = false unless item
      else
        return result = false unless var === item
      end
    end
    result
  end

  def my_any?(var = nil)
    result = true
    my_each do |item|
      if block_given?
        return result = true if yield(item)
      elsif var.nil?
        return result = true if item
      else
        return result = true if var === item
      end
    end
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
    return to_enum unless block_given? || arr

    result = []
    if block_given? && arr.nil?
      my_each do |item|
        result.push(yield(item))
      end
    else
      my_each do |item|
        result.push(arr.call(item))
      end
    end
    result
  end

  def my_inject(*args)
    result = 0
    if args.count == 0
      self.my_each {|num|
        args = yield(args, num)
      }
    else
      args = args[0]
      self.my_each{|num|
        args = yield(args, num)
      }
      return args
    end
  end

  def multiply_els
    my_inject { |total, item| total * item }
  end
end

print 'Test Multiply ELS'
puts
puts([2, 4, 5].multiply_els)

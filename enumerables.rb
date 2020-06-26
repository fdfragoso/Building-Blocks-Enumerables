module Enumerable
  def my_each(var = nil)
    return to_enum unless block_given?

    i = if var.nil?
          0
        else
          var
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

  def my_count(var = nil)
    result = []
    if block_given?
      my_each do |item|
        result.push(item) if yield(item)
      end
    elsif var.nil?
      return length
    else
      my_each do |item|
        result.push(item) if item == var
      end
    end
    result.length
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
    if args.count.zero?
      my_each { |num| args = yield(args, num) }
    else
      args = args[0]
      my_each { |num| args = yield(args, num) }
      args
    end
  end
end

def multiply_els
  my_inject { |total, item| total * item }
end

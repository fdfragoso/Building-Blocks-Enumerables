# rubocop: disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i <= size - 1
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    selected = []
    my_each do |item|
      selected.push(item) if yield(item)
    end
    selected
  end

  # rubocop: disable Style/CaseEquality, Style/IfInsideElse
  def my_all?(var = nil)
    result = true
    my_each do |item|
      if block_given?
        result = false unless yield(item)
      elsif var.nil?
        result = false unless item
      else
        result = false unless var === item
      end
    end
    result
  end

  def my_any?(var = nil)
    result = false
    my_each do |item|
      if block_given?
        result = true if yield(item)
      elsif var.nil?
        result = true if item
      else
        result = true if var === item
      end
    end
    result
  end

  def my_none?(var = nil)
    result = true
    my_each do |item|
      if block_given?
        result = false if yield(item)
      elsif var.nil?
        result = false if item
      else
        result = false if var === item
      end
    end
    result
  end

  # rubocop: enable Style/CaseEquality, Style/IfInsideElse
  def my_count(var = nil)
    result = 0
    if block_given?
      my_each { |item| result += 1 if yield(item) == true }
    elsif var.nil?
      my_each { result += 1 }
    else
      my_each { |item| result += 1 if item == var }
    end
    result
  end

  def my_map(arg = nil)
    return to_enum if arg.nil? && block_given? == false

    output_arr = []
    my_each do |val|
      if arg
        output_arr.push(arg.call(val))
      else
        output_arr.push(yield(val))
      end
    end
    output_arr
  end

  def my_inject(*args)
    arr = to_a.dup
    if args[0].nil?
      operation = arr.shift
    elsif args[1].nil? && !block_given?
      symbol = args[0]
      operation = arr.shift
    elsif args[1].nil? && block_given?
      operation = args[0]
    else
      operation = args[0]
      symbol = args[1]
    end
    arr[0..size].my_each do |elem|
      operation = if symbol
                    operation.send(symbol, elem)
                  else
                    yield(operation, elem)
                  end
    end
    operation
  end
end

# rubocop: enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(arr)
  arr.my_inject('*')
end

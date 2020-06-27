# rubocop: disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i <= size - 1
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
      my_each do |item|
        result += 1 if yield(item)
      end
      result
    elsif var.nil?
      length
    else
      my_each do |item|
        result += 1 if item == var
      end
      result
    end
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

  def my_inject(arg1 = nil, arg2 = nil)
    if block_given?
      my_each do |item|
        arg1 = arg1.nil? ? to_a[0] : yield(arg1, item)
      end
      arg1

    elsif arg1
      i = arg2.nil? ? 1 : 0
      total = arg2.nil? ? to_a[0] : arg1
      operator = arg2.nil? ? arg1 : arg2

      while i < size
        total = to_a[i].send(operator, total)
        i += 1
      end
      total
    else
      to_enum
    end
  end
end

# rubocop: enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(arr)
  arr.my_inject('*')
end

require_relative '../enumerables.rb'

RSpec.describe Enumerable do
  include Enumerable
  let(:arr) { [1, 2, 3] }
  let(:arr2) { [1, -2, 3] }
  let(:words) { %w[ant bear cat] }
  let(:words2) { %w[ant sheep dinosaur] }
  let(:mixed) { [nil, true, 99] }
  let(:longest) do
    proc do |memo, word|
      memo.length > word.length ? memo : word
    end
  end
  let(:identify) do
    proc do |_item|
      'proc'
    end
  end

  describe '#my_each' do
    it 'returns exaclty the same as the original function when passed a block' do
      expect(arr.my_each { |x| puts x }).to eql(arr.each { |x| puts x })
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_each).to be_a(Enumerator)
    end

    it 'should throw an argument error if passed an argument' do
      expect { arr.my_each('test') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_each_with_index' do
    it 'returns exaclty the same as the original function when passed a block' do
      expect(arr2.my_each { |x| puts x + 3 * 2 }).to eql(arr2.each { |x| puts x + 3 * 2 })
    end

    it 'returns an enumerator if no block is given' do
      expect(arr2.my_each).to be_a(Enumerator)
    end

    it 'should throw an argument error if passed an argument' do
      expect { arr2.my_each('test') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_select' do
    it 'returns exaclty the same as the original function when passed a block' do
      expect(arr.my_select { |num| num.even? } ).to eql([2])
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_select).to be_a(Enumerator)
    end

    it 'should throw an argument error if passed an argument' do
      expect { arr.my_select('test') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_count' do
    it 'returns exaclty the number of items in the array ' do
      expect(arr.my_count).to eql(3)
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_count(1)).to eql(1)
    end

    it 'should count how many times the block condition is true' do
      expect(arr.my_count { |num| num.even? } ).to eql(1)
    end
  end

  describe '#my_all?' do
    it 'returns true if certifies the condition ' do
      expect(arr.my_all?).to eql(true)
    end

    it 'returns the length of the block' do
      expect(words.my_all? { |num| num.length >= 3} ).to eql(true)
    end

     it 'returns the length of the block' do
        expect(words2.my_all? { |num| num.length <=1 } ).to eql(false)
     end
  end

  describe '#my_any?' do
    it 'returns true if certifies the condition ' do
      expect(arr.my_any?).to eql(true)
    end

    it 'returns the length of the block' do
      expect(words.my_any? { |num| num.length >= 3} ).to eql(true)
    end

     it 'returns the length of the block' do
        expect(words2.my_any? { |num| num.length <=1 } ).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'returns true if certifies the condition ' do
      expect(arr.my_none?).to eql(false)
    end

    it 'returns the length of the block' do
      expect(words.my_none? { |num| num.length >= 5} ).to eql(true)
    end

    it 'returns the length of the block' do
      expect(words2.my_none? { |num| num.length <=20 } ).to eql(false)
    end
  end

  describe '#my_inject' do
    it 'accepts a symbol that references a block as an argument' do
      expect(arr.my_inject(:+)).to eq(6)
    end
  
    it 'accepts a block' do
      expect((5..10).my_inject(1, :*)).to eq(151_200)
    end

    it 'accepts an argument as an initiator value well a block' do
      expect(arr2.my_inject(1) { |product, n| product * n}).to eq(-6)
    end

    it 'accepts an argument as an initiator value well a block' do
      expect(words2.my_inject(&longest)).to eq('dinosaur')
    end
  end

  describe '#my_map' do
    it 'accepts a symbol that references a block as an argument' do
      expect(arr.my_map(&:to_s)).to eq(%w[1 2 3])
    end
  
    it 'accepts a block and returns it as array' do
      expect(arr.my_map { |i| i * i }).to eq([1, 4, 9])
    end
  
    it 'returns an item dictated by the block passed to it for every item in the array' do
      expect(arr.my_map { 'cat' }).to eql(Array.new(3, 'cat'))
    end

    it 'if both proc argument and block given, the proc will be used' do
      expect(arr.my_map(identify) { |_item| 'block' }).to eql(Array.new(3, 'proc'))
    end
  end
end
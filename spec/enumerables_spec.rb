require_relative '../enumerables.rb'

RSpec.describe Enumerable do
  include Enumerable
  let(:arr) { [1, 2, 3] }
  let(:arr2) { [1, -2, 3] }
  let(:words) { %w[ant bear cat] }
  let(:words2) { %w[ant sheep dinousaur] }
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
end
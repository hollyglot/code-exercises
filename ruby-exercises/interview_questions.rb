require 'benchmark'

hashie = { abc: 'hello', 'another_key' => 123, 4567 => 'third' }

def sortByLength(hashie)
  sorted_ary = hashie.sort { |a,b| a[0].to_s.length <=> b[0].to_s.length }
  hash = {}
  sorted_ary.each do |ary|
    hash[ary[0]] = ary[1]
  end
  puts hash
end

sortByLength(hashie)

def sortKeys(hashie)
  sorted_ary = hashie.keys.sort { |a,b| a.to_s.length <=> b.to_s.length }
  sorted_ary.each_with_index { |val,i| sorted_ary[i] = val.to_s }
  puts sorted_ary.inspect
end

Benchmark.bm do |x|
  x.report do 
    sortKeys(hashie)
  end
end


Benchmark.bm do |x|
  x.report do 
    puts hashie.keys.map(&:to_s).sort_by(&:length).inspect
  end
end
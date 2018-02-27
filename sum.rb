require 'benchmark'
require 'active_support/core_ext/enumerable.rb'

arr = [1, 1.001, 2.34, 5.678, 7, 8.08, 8.0, 8.01, 123, 456789000011]

Benchmark.bm(6) do |b|
  b.report("inject") { 1_000_000.times { arr.inject(:+) } } # 10.018999999999998
  b.report("sum") { 1_000_000.times { arr.sum } } # 10.019
end

require 'benchmark'

list = (0..1_000).to_a

Benchmark.bm(6) do |b|
  b.report('flat_map') { 10_000.times { list.flat_map { |x| [x, x * x] } } }
  b.report('map.flatten') { 10_000.times { list.map { |x| [x, x * x] }.flatten } }
end

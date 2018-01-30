require 'benchmark'
require 'active_support/core_ext/object/try'

Benchmark.bm(4) do |b|
  b.report("&") { 1_000_000.times { nil&.bar } }
  b.report("try") { 1_000_000.times { nil.try(:bar) } }
end

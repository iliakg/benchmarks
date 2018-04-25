require 'benchmark'
require 'date'

BEGIN_OF_JULY = Date.new(2015, 7, 1)
END_OF_JULY = Date.new(2015, 7, 31)
DAY_IN_JULY = Date.new(2015, 7, 15)

Benchmark.bm(6) do |b|
  b.report('cover') { 100_000.times { (BEGIN_OF_JULY..END_OF_JULY).cover?(DAY_IN_JULY) } }
  b.report('include') { 100_000.times { (BEGIN_OF_JULY..END_OF_JULY).include?(DAY_IN_JULY) } }
  b.report('member') { 100_000.times { (BEGIN_OF_JULY..END_OF_JULY).member?(DAY_IN_JULY) } }
end

range = (0..1_000_000)
Benchmark.bm(6) do |b|
  b.report('cover') { 100_000.times { range.cover?(555_555) } }
  b.report('include') { 100_000.times { range.include?(555_555) } }
  b.report('member') { 100_000.times { range.member?(555_555) } }
end

#              user     system      total        real
# cover    0.055907   0.000609   0.056516 (  0.063163)
# include  1.663943   0.018944   1.682887 (  1.730768)
# member   1.561601   0.007800   1.569401 (  1.577235)
#              user     system      total        real
# cover    0.016693   0.000047   0.016740 (  0.016769)
# include  0.015381   0.000048   0.015429 (  0.015480)
# member   0.017537   0.000264   0.017801 (  0.018541)

require 'benchmark'
require 'active_support/core_ext/object/try'

h = { a: { b: { c: { d: { e: "foo" } } } } }

Benchmark.bm(20) do |b|
  b.report('Hash#dig') { 1_000_000.times { h.dig(:a, :b, :c, :d, :e) } }
  b.report('Hash#[]') { 1_000_000.times { h[:a][:b][:c][:d][:e] } }
  b.report('Hash#[] ||') { 1_000_000.times { ((((h[:a] || {})[:b] || {})[:c] || {})[:d] || {})[:e] } }
  b.report('Hash#[] &&') { 1_000_000.times { h[:a] && h[:a][:b] && h[:a][:b][:c] && h[:a][:b][:c][:d] && h[:a][:b][:c][:d][:e] } }
  b.report('Hash#fetch') { 1_000_000.times { h.fetch(:a).fetch(:b).fetch(:c).fetch(:d).fetch(:e) } }
  b.report('Hash#fetch fallback') { 1_000_000.times { h.fetch(:a, {}).fetch(:b, {}).fetch(:c, {}).fetch(:d, {}).fetch(:e, nil) } }
  b.report('try :[]') { 1_000_000.times { h.try(:[], :a).try(:[], :b).try(:[], :c).try(:[], :d).try(:[], :e) } }

  b.report('fail fetch') { 1_000_000.times { h.fetch(:t, {}).fetch(:t, {}).fetch(:t, {}).fetch(:t, {}).fetch(:t, {}) } }
  b.report('fail try') { 1_000_000.times { h.try(:[], :t).try(:[], :t).try(:[], :t).try(:[], :t).try(:[], :t) } }

  b.report('fail fetch') { 1_000_000.times { h.fetch(:a, {}) } }
  b.report('fail try') { 1_000_000.times { h.try(:[], :a) } }

  b.report('one fail fetch') { 10_000_000.times { h.fetch(:a, {}) } }
  b.report('one fail if') { 10_000_000.times { h[:a] ? h[:a] : {} } }
end

#                            user     system      total        real
# Hash#dig               0.160000   0.010000   0.170000 (  0.160676)
# Hash#[]                0.140000   0.000000   0.140000 (  0.146767)
# Hash#[] ||             0.150000   0.000000   0.150000 (  0.147295)
# Hash#[] &&             0.350000   0.000000   0.350000 (  0.359955)
# Hash#fetch             0.230000   0.000000   0.230000 (  0.230163)
# Hash#fetch fallback    0.330000   0.010000   0.340000 (  0.333978)
# try :[]                2.480000   0.000000   2.480000 (  2.494699)
# fail fetch             0.300000   0.000000   0.300000 (  0.303882)
# fail try               1.020000   0.010000   1.030000 (  1.026590)
# fail fetch             0.110000   0.000000   0.110000 (  0.105815)
# fail try               0.540000   0.000000   0.540000 (  0.541901)
# one fail fetch         1.020000   0.000000   1.020000 (  1.026760)
# one fail if            1.020000   0.010000   1.030000 (  1.024839)

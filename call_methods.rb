require 'benchmark'

class Foo
  def bar; end
end

Benchmark.bm(6) do |b|
  b.report("bar") { 1_000_000.times { Foo.new.bar } }
  b.report("send") { 1_000_000.times { Foo.new.send(:bar) } }
  b.report("call") { 1_000_000.times { Foo.new.method(:bar).call } }
end


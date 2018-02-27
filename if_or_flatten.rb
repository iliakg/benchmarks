require 'benchmark'

h = { test: 123 }
arr = [{ test: 123 }]

Benchmark.bm(10) do |b|
  b.report('check') do
    1_000_000.times do
      h.is_a?(Hash) ? [] << h : h
      arr.is_a?(Hash) ? [] << arr : arr
    end
  end

  b.report('flatten') do
    1_000_000.times do
      ([] << h).flatten
      ([] << arr).flatten
    end
  end
end

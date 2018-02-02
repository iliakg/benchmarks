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

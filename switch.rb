require 'benchmark'

class Test
  class << self
    def method_1
      'method_1'
    end

    def method_2
      'method_2'
    end

    def method_3
      'method_3'
    end

    def method_4
      'method_4'
    end

    def method_5
      'method_5'
    end

    def method_6
      'method_6'
    end

    def method_7
      'method_7'
    end

    def method_8
      'method_8'
    end

    def method_9
      'method_9'
    end

    def method_10
      'method_10'
    end
  end
end

Benchmark.bm(6) do |b|
  b.report("method") do
    1_000_000.times do
      num = rand(1..10)
      case num
      when 1
        Test.method_1
      when 2
        Test.method_2
      when 3
        Test.method_3
      when 4
        Test.method_4
      when 5
        Test.method_5
      when 6
        Test.method_6
      when 7
        Test.method_7
      when 8
        Test.method_8
      when 9
        Test.method_9
      when 10
        Test.method_10
      else
        "else"
      end
    end
  end

  b.report("send") do
    1_000_000.times do
      num = rand(1..10)
      Test.send("method_#{num}")
    end
  end
end

require 'benchmark'
def measure(frequency = 1)
  result = Benchmark.measure do
    frequency.times do
      yield
    end
  end
#Benchmark gives a Benchmark object that has a result attribute
  result.real / frequency
end

require 'pry'

class Hash
  def hmap(&blk)
    Hash[self.map{|key,val| blk.call(key, val) }]
  end

  def hmap!(&blk)
    mutated = self.hmap(&blk)
    self.replace(mutated)
  end
end

x = {}
(1..10000).each do |i|
  x["key#{i}"] = i
end


t=Time.now

x.hmap!{|key,val| [key.to_sym, val.to_s]}


puts "#{Time.now - t} seconds"

binding.pry


puts "hello"

require 'byebug'
class Employee
  attr_accessor :boss
  attr_reader :name, :title, :salary

  def initialize(options)
    @name = options[:name]
    @title = options[:title]
    @salary = options[:salary]
    @boss = options[:boss]
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee
  attr_reader :subordinates
  def initialize(options)
    super
    @subordinates = []
  end

  def directly_manage(employee)
    @subordinates << employee
    employee.boss = self
  end

  def oversee
    overseeing = []
    queue = self.subordinates.map{|subord| subord }

    until queue.empty?
      employee = queue.shift
      overseeing << employee

      if employee.is_a?(Manager)
        employee.subordinates.each{|subord| queue << subord}
      end
    end

    overseeing
  end

  def bonus(multiplier)
    self.oversee.inject(0){|accum, subord| accum + subord.salary} * multiplier
  end
end




ned = Manager.new( name: "ned", title: "founder", salary: 1_000_000 )
darren = Manager.new( name: "darren", title: "founder", salary: 78_000,
  boss: ned)

ned.directly_manage(darren)


david = Employee.new( name: "david", title: "TA",
  salary: 10_000, boss: darren )
shawna = Employee.new( name: "shawna", title: "TA",
  salary: 12_000, boss: darren )

darren.directly_manage(shawna)
darren.directly_manage(david)

puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)

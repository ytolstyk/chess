
class Employee
  attr_reader :salary
  
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @boss.add_employee(self) if boss
  end
  
  def bonus(multiplier)
    @salary * multiplier
  end
  
  
end

class Manager < Employee
  
  def initialize(name, title, salary, boss = nil)
    @team = []
    super
  end
  
  def add_employee(employee)
    @team << employee
  end
  
  def bonus(multiplier)
    team_salary * multiplier
  end
    
  def team_salary
    total = 0
    @team.each do |employee|
      total += employee.salary
    end
    total
  end
  
end
module Tasks

  1.upto(20) do |n|
    define_method("task#{n}") do
      Task.find_by_name("task#{n}") || Task.create({name: "task1#{n}", project: self.send("project#{n%9 + 1}")})
    end
  end
  
end
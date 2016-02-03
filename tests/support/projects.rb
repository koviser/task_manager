module Projects
  
  1.upto(9) do |n|
    define_method("project#{n}") do
      Project.find_by_name('project#{n}') || Project.create({name: 'project#{n}', user: self.send("user#{n%3 + 1}")})
    end
  end

end
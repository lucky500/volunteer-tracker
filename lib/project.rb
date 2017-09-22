class Project
  attr_accessor(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(otherproject)
    self.title.==(otherproject.title)
  end

  def self.all
    project_list = DB.exec("SELECT * FROM projects;")
    projects = []
    project_list.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.find(id)
    Project.all.each do |project|
      if project.id == id
        return project
      end
    end
  end


end

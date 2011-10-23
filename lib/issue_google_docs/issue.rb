module IssueGoogleDocs
  class Issue

    attr :type, true
    attr :description, true
    attr :story_points, true
    attr :hours, true
    attr :acceptance_tests, true
    attr :tasks, true

    def initialize(type, description, story_points, hours)
      @type = type
      @description = description
      @story_points = story_points
      @hours = hours
      
      @tasks = Array.new

    end

    def add_task(task)
      @tasks.push(task)
    end
  end
end

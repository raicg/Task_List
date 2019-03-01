require 'rails_helper'

user = User.create({name: "teste", email: "teste@teste.com", password: "123456"})
user.save()

RSpec.describe Task, type: :model do
  context "Verifying register of a new task." do
    it "Title cannot be null." do
      task = Task.new
      task.title = nil
      task.description = "description"
      task.user_id = User.last.id
      task.due_date = Time.current().tomorrow()

      expect(task.valid?).to be_falsey
    end
    
    it "Title needs to have at least 5 characters." do
      task = Task.new
      task.title = "1234"
      task.description = "description"
      task.user_id = User.last.id
      task.due_date = Time.current().tomorrow()

      expect(task.valid?).to be_falsey
    end
    
      
    it "Due Date needs to be later then now." do
      task = Task.new
      task.title = "Title"
      task.description = "description"
      task.user_id = User.last.id
      task.due_date = Time.current().yesterday()

      expect(task.valid?).to be_falsey
    end

    it "Task valid" do

      task = Task.new
      task.title = "Title"
      task.description = "description"
      task.user_id = User.last.id
      task.due_date = Time.current().tomorrow()

      expect(task.valid?).to be_truthy
    end
  end

end

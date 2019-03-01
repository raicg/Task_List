require 'rails_helper'
RSpec.describe TaskController, type: :controller do

  let(:valid_attributes) {
    {title: "title", description: "description", user_id: User.last.id, due_date: Time.current().tomorrow()}
}

  let(:invalid_attributes) {
    {title: nil, description: "description", user_id: User.new.id, due_date: Time.current().yesterday()}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TasksController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  user = User.create({name: "teste", email: "teste@teste.com", password: "123456"})
  user.save()

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      task = Task.create! valid_attributes
      get :edit, params: {id: task.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do

    context "with valid params" do
      it "creates a new Task" do

        sign_in User.last
        expect {
          post :create, params: {task: valid_attributes}, session: valid_session
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        sign_in User.last
        post :create, params: {task: valid_attributes}, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        sign_in User.last
        post :create, params: {task: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: "title2", description: "description2", user_id: User.last.id, due_date: Time.current().tomorrow()}
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        put :update, params: {id: task.to_param, task: new_attributes}, session: valid_session
        task.reload
        
        {title: "title3", description: "description3", user_id: User.last.id, due_date: Time.current().tomorrow()}  
      end

      it "redirects to home" do
        task = Task.create! valid_attributes
        put :update, params: {id: task.to_param, task: valid_attributes}, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        put :update, params: {id: task.to_param, task: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, params: {id: task.to_param}, session: valid_session, format: :js 
      }.to change(Task, :count).by(-1)
    end
  end


  describe "GET #change_status" do
    it "returns a success response" do

      ActionController::Base.allow_forgery_protection = false
      task = Task.create! valid_attributes
      patch :change_status, params: {id: task.to_param}, session: valid_session, format: :js
      task.reload

      expect(task.status?).to be_truthy
    end
  end

end

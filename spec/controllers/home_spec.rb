require 'rails_helper'
RSpec.describe TaskController, type: :controller do

  describe "GET #index" do
    it "returns a success response" do
      user = User.last
      sign_in user
      get :index, session: valid_session
      expect(response).to be_successful
    end


  end

end

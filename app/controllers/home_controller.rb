class HomeController < ApplicationController
  def index_anonymous
  end

  def index
    @task = Task.where(user_id: current_user.id)
  end

  def search
  end
end

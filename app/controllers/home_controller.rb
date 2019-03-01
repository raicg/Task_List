class HomeController < ApplicationController
  def index_anonymous
  end

  def index

    if current_user.admin?
      @task = Task.all()
    else
      @task = Task.where(user_id: current_user.id)
    end
    @task = if params[:term]
      @task = @task.where('title || description LIKE ?', "%#{params[:term]}%")
    else
      @task = @task
    end
  
  end


  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :user_id, :term)
  end


end

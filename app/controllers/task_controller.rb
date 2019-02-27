class TaskController < ApplicationController

  def index
    @task = Task.new()
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:success] = "Corrida criada"
      redirect_to root_path
    else
      print "erro aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      render :index
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end




  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :user_id)
  end

end

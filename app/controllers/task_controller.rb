class TaskController < ApplicationController

  def index
    @task = Task.new()
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:success] = "Task created."
      redirect_to root_path
    else
      @error = @task.errors.full_messages
      render :index
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.js
    end
  end

  def change_status
    @task = Task.find(params[:id])
    if @task.status == false
      @task.status = true
    else
      @task.status = false
    end
    @task.save()
    respond_to do |format|
      format.js
    end
  end

  def edit 
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to root_path()
      else 
        @error = @task.errors.full_messages
        render 'edit'
      end
  end


  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :user_id, :status)
  end

end

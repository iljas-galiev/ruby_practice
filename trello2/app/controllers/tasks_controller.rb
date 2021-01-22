class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'Task added!'
      redirect_to tasks_path
    else
      flash[:error] = 'Failed to save task!'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:notice] = 'Task updated!'
      redirect_to tasks_path
    else
      flash[:error] = 'Failed to save task!'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = "Task '#{@task.id}' deleted. "
      redirect_to tasks_path
    end
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end

class TasksController < ApplicationController
  include AuthHelper
  before_action :logged_in_user

  def index
    redirect_to cards_path
  end

  def show
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to cards_path
      return
    end

    if @task.user_id != current_user.id
      flash[:danger] = 'Ошибка'
      redirect_to cards_path
      return
    end
  end

  def new
    @task = Task.new
    @task.card_id = params[:id]

    @card = Card.find_by(id: @task.card_id)
  end

  def create
    @task = Task.new(task_params)
    @card = Card.find_by(id: @task.card_id)

    if @card.nil? || @card.user_id != current_user.id
      flash[:danger] = 'Ошибка при сохранении'
      redirect_to cards_path
      return
    end

    @task.user_id = current_user.id
    if @task.save
      flash[:primary] = 'Задача добавлена'
      redirect_to cards_path
    else
      flash[:danger] = 'Ошибка при сохранении'
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to cards_path
      return
    end

    if @task.user_id != current_user.id
      flash[:danger] = 'Ошибка'
      redirect_to cards_path
      return
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.nil?
      redirect_to cards_path
      return
    end

    if @task.user_id != current_user.id
      flash[:danger] = 'Ошибка'
      redirect_to cards_path
      return
    end

    if @task.update_attributes(task_params)
      flash[:primary] = 'Задача обновлена'
      redirect_to cards_path
    else
      flash[:danger] = 'Ошибка при сохранении'
      render :edit
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      redirect_to cards_path
      return
    end

    if @task.user_id != current_user.id
      flash[:danger] = 'Ошибка'
      redirect_to cards_path
      return
    end

    if @task.destroy
      flash[:primary] = "Задача #{@task.title} удалена"
      redirect_to cards_path
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :card_id)
  end

end

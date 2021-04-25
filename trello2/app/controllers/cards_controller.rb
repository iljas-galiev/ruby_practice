class CardsController < ApplicationController
  include AuthHelper
  before_action :logged_in_user

  def index
    if params[:archive]
      @cards = Card.archive.user(current_user.id).all
    else
      @cards = Card.not_archive.user(current_user.id).all
    end
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.user_id = current_user.id
    if @card.save
      flash[:primary] = 'Карточка добавлена'
      redirect_to cards_path
    else
      flash[:danger] = 'Ошибка при сохранении карточки'
      render :new
    end
  end

  def edit
    @card = Card.find_by(id: params[:id], user_id: current_user.id)


    if @card.nil?
      redirect_to cards_path
    end
  end

  def update
    @card = Card.find_by(id: params[:id], user_id: current_user.id)


    if @card.nil?
      redirect_to cards_path
    end

    if @card.update_attributes(card_params)
      flash[:primary] = 'Карточка обновлена'
      redirect_to cards_path
    else
      flash[:danger] = 'Ошибка при сохранении карточки'
      render :edit
    end
  end

  def destroy
    @card = Card.find_by(id: params[:id], user_id: current_user.id)
    if @card.nil?
      redirect_to cards_path
    end
    if @card.destroy
      flash[:primary] = "Карточка #{@card.name} удалена"
      redirect_to cards_path
    end
  end

  def card_params
    params.require(:card).permit(:name)
  end
end

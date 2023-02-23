class ListsController < ApplicationController
  def index
    @header = 'My lists'
    @lists = List.all
  end

  def new
    @header = 'New list'
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list = List.find(params[:id])
    @header = @list.name
    @bookmark = Bookmark.new
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end

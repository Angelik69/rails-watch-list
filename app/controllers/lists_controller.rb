require 'open-uri'

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
    if params[:list][:photo].nil?
      @list.photo.attach(io: URI.open('https://images.unsplash.com/photo-1542204165-65bf26472b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bW92aWVzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60'),
                        filename: "default.avif", content_type: "image/avif")
    end
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

  def destroy
    @list = List.find(params[:id])
    @header = @list.name
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end

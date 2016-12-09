class AlbumsController < ApplicationController
  def new
    @band = Band.find(params[:band_id])
    @album = Album.new
    render :new
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def create
    album = Album.new(album_params)
    if album.save
      redirect_to album_url(album)
    else
      flash.now[:errors] = album.errors.full_messages
      render album_url(album)
    end
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to band_url(album.band)
  end

  private
  def album_params
    params.require(:album).permit(:name, :quality, :band_id)
  end
end

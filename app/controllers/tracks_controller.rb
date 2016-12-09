class TracksController < ApplicationController
  def new
    @album = Album.find(params[:album_id])
    # fail
    @track = Track.new
    render :new
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def create
    track = Track.new(track_params)
    if track.save
      redirect_to track_url(track)
    else
      flash.now[:errors] = track.errors.full_messages
      render track_url(track)
    end
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy
    redirect_to album_url(track.album)
  end

  private
  def track_params
    params.require(:track).permit(:name, :lyrics, :status, :album_id)
  end
end

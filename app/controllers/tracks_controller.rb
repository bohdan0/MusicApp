class TracksController < ApplicationController
  before_action :logged_in?

  def new

  end

  def show
    @track = Track.find(params[:id])
  end

  def create
    @track = Track.new(track_params)
    @track.album_id = params[:album_id]

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
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
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy
    redirect_to album_url(track.album)
  end

  private
  def track_params
    params.require(:track).permit(:name, :lyrics, :status)
  end
end

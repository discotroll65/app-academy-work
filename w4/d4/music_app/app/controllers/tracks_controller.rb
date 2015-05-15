class TracksController < ApplicationController
  before_action :ensure_logged_in!

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @band = Band.find(@album.band_id)
    render :new
  end

  def create
    @track = Track.new(track_params)
    @album = Album.find(@track.album_id)
    @band = Band.find(@album.band_id)
    if @track.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @track.band
  end

  private
    def track_params
      params.require(:track).permit(:lyrics, :album_id, :name, :track_type)
    end
end

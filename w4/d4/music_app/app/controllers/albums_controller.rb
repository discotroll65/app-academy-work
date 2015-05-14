class AlbumsController < ApplicationController
  def index
    @albums = Album.all
    render :index
  end

  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    :new
  end

  def create
    @album = Album.new(album_params)
    @band = Band.find(@album.band_id)
    if @album.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    @tracks = @album.tracks
    render :show
  end


  private
    def album_params
      params.require(:album).permit(:band_id, :name, :recording_style)
    end
end

class AnimesController < ApplicationController
  before_action :set_anime, only: [:show, :edit, :update, :destroy]
  before_action :set_studios, only: [:new, :edit, :create, :update]

  def index
    @animes = Anime.all
  end

  def show
  end

  def new
    @anime = Anime.new
  end

  def edit
  end

  def create
    @anime = Anime.new(anime_params)

    respond_to do |format|
      if @anime.save
        format.html { redirect_to @anime, notice: 'Anime was successfully created.' }
        format.json { render :show, status: :created, location: @anime }
      else
        format.html { render :new }
        format.json { render json: @anime.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @anime.update(anime_params)
        format.html { redirect_to @anime, notice: 'Anime was successfully updated.' }
        format.json { render :show, status: :ok, location: @anime }
      else
        format.html { render :edit }
        format.json { render json: @anime.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @anime.destroy
    respond_to do |format|
      format.html { redirect_to animes_url, notice: 'Anime was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_anime
      @anime = Anime.find(params[:id])
    end

    def anime_params
      params.require(:anime).permit(:title, :year, :season_id, :studio_id)
    end

    def set_studios
      @studios = Studio.all.order(:name)
    end
end

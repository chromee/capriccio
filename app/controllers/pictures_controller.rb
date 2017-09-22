class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: [:create]
  before_action :set_animes, only: [:new, :edit, :create, :update]

  PER_PAGE = 30

  def index
    if params[:search].present?
      keywords = params[:search].split(",")
      @pictures = Picture.tagged_with keywords, any: true
      @pictures = @pictures.page(params[:page]).per(PER_PAGE)
    else
      @pictures = Picture.all.order("id desc").page(params[:page]).per(PER_PAGE)
    end
  end

  def show
    @anime = Anime.find_by_id(@picture.anime_id)
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        save_pictures_characters_relation(params[:character_ids].split(",")) if params[:character_ids].present?
        format.html { redirect_to @picture, notice: '画像がアップロードされまし' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, notice: "画像のアップロードに失敗しました" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        save_pictures_characters_relation(params[:character_ids]) if params[:character_ids].present?
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def set_animes
      @animes = Anime.all.order(:title)
    end

    def picture_params
      if request.path_parameters[:format] == "json"
        json_request = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_request.require(:picture).permit(:name, :photo, :tag_list, :anime_id)
      else
        params.require(:picture).permit(:name, :photo, :tag_list, :anime_id)
      end
    end

    def save_pictures_characters_relation(character_ids)
      character_ids.each do |character_id|
        PicturesCharactersRelation.create(picture_id: @picture.id, character_id: character_id.to_i)
      end
    end

end

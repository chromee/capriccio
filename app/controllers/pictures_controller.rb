class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :set_anime, only: [:show, :edit]
  protect_from_forgery except: [:create]
  before_action :set_animes, only: [:new, :edit, :create, :update]
  before_action :set_anime_id_to_params, only: [:create, :update]

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
        flash[:info] = "画像がアップロードされました"
        save_pictures_characters_relation if params[:character_names].present?
        format.html { redirect_to @picture }
        format.json { render :show, status: :created, location: @picture }
      else
        flash[:danger] = "画像のアップロードに失敗しました"
        format.html { render :new  }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        flash[:info] = "画像が更新されました"
        save_pictures_characters_relation if params[:character_names].present?
        format.html { redirect_to @picture }
        format.json { render :show, status: :ok, location: @picture }
      else
        flash[:danger] = "画像の更新に失敗しました"
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      flash[:danger] = "画像が削除されました"
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def set_anime
      @anime = Anime.find_by_id(@picture.anime_id)
    end

    def set_animes
      @animes = Anime.all.order(:title)
    end

    def set_anime_id_to_params
      return if params[:anime_title].blank?
      anime = Anime.find_by_title(params[:anime_title])
      if anime.nil?
        flash[:danger] = "アニメが登録されていませんでした"
        return
      end
      params[:picture][:anime_id] = anime.id
    end

    def picture_params
      if request.path_parameters[:format] == "json"
        json_request = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_request.require(:picture).permit(:name, :photo, :tag_list, :anime_id)
      else
        params.require(:picture).permit(:name, :photo, :tag_list, :anime_id)
      end
    end

    def save_pictures_characters_relation
      character_ids = character_ids.split(",")
      character_ids.each do |character_id|
        PicturesCharactersRelation.create(picture_id: @picture.id, character_id: character_id.to_i)
      end
    end

end

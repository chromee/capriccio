class CapturesController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :set_capture, only: [:show, :edit, :update, :destroy]
  before_action :set_anime, only: [:show, :edit]
  before_action :set_animes, only: [:new, :edit, :create, :update]
  before_action :set_anime_id_to_params, only: [:create, :update]

  PER_PAGE = 30

  def index
    @captures = Capture.all.order("id desc")
    if params[:search].present?
      keywords = params[:search].split(",")
      @captures = @captures.tagged_with keywords, any: true
    end
    @captures = @captures.page(params[:page]).per(PER_PAGE)
  end

  def show
  end

  def new
    @capture = Capture.new
  end

  def edit
  end

  def create
    @capture = Capture.new(capture_params)
    respond_to do |format|
      if @capture.save
        trimming_face
        flash[:info] = "画像がアップロードされました"
        format.html { redirect_to @capture }
        format.json { render :show, status: :created, location: @capture }
      else
        flash[:danger] = "画像のアップロードに失敗しました"
        format.html { render :new }
        format.json { render json: @capture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @capture.update(capture_params)
        trimming_face
        flash[:info] = "画像が更新されました"
        format.html { redirect_to @capture }
        format.json { render :show, status: :ok, location: @capture }
      else
        flash[:danger] = "画像の更新に失敗しました"
        format.html { render :edit }
        format.json { render json: @capture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @capture.destroy
    respond_to do |format|
      flash[:danger] = "画像が削除されました"
      format.html { redirect_to captures_url }
      format.json { head :no_content }
    end
  end

  private
    def set_capture
      @capture = Capture.find(params[:id])
    end

    def set_anime
      @anime = @capture.anime
    end

    def set_animes
      @animes = Anime.all.order(:title)
    end

    def set_anime_id_to_params
      return if params[:anime_title].blank?
      unless anime = Anime.find_by_title(params[:anime_title])
        return flash[:danger] = "アニメが見つかりませんでした"
      end
      params[:capture][:anime_id] = anime.id
    end

    def capture_params
      params.require(:capture).permit(:name, :picture, :tag_list, :anime_id)
    end

    def trimming_face
      return if params[:characters].blank?
      caharacters_name = params[:characters].values.map {|c| c[:name] }
      characters = Character.where(name: caharacters_name).to_a
      params[:characters].values.each do |character|
        character.each {|k,v| character[k] = v.to_i unless k == :character_id }
        character[:character_id] = characters.find {|c| c.name == character[:name] }.try(:id)
        @capture.trimming_face character
      end
    end

end

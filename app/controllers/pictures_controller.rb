class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: [:create]

  PER_PAGE = 20

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

    def picture_params
      if request.path_parameters[:format] == "json"
        json_request = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_request.require(:picture).permit(:name, :photo, :tag_list)
      else
        params.require(:picture).permit(:name, :photo, :tag_list)
      end
    end
end

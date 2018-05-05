class CapturesController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :set_capture, only: [:show, :edit, :update, :destroy, :favorite]

  PER_PAGE = 30

  def index
    @captures = Capture.all.order("id desc")
    case params[:serch_type_id].to_i
    when SearchType::COMMENT.id
      @captures = @captures.where("comment like ?", "%#{params[:search_text]}%")
    when SearchType::TAG.id
      keywords = params[:search_text].split(",")
      @captures = @captures.tagged_with keywords, any: true
    end
    if params[:favorite]
      @favorites = UserFavoriteCapture.where(user_id: current_user.id)
      @captures = @captures.where(id: @favorites.map(&:capture_id))
    end
    @captures = @captures.page(params[:page]).per(PER_PAGE)
  end

  def show
    @favorite = UserFavoriteCapture.all.where(user_id: current_user.id, capture_id: @capture.id).first&.favorite if user_signed_in?
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
        @capture.generate_message! if capture_params[:comment].blank?
        flash[:info] = "capture uploaded."
        format.html { redirect_to @capture }
        format.json { render :show, status: :created, location: @capture }
      else
        flash[:danger] = "failed uploading."
        format.html { render :new }
        format.json { render json: @capture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @capture.update(capture_params)
        flash[:info] = "updated."
        format.html { redirect_to @capture }
        format.json { render :show, status: :ok, location: @capture }
      else
        flash[:danger] = "failed updateing."
        format.html { render :edit }
        format.json { render json: @capture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @capture.destroy
    respond_to do |format|
      flash[:danger] = "deleted"
      format.html { redirect_to captures_url }
      format.json { head :no_content }
    end
  end

  def favorite
    @favorite = UserFavoriteCapture.find_or_create_by(user_id: current_user.id, capture_id: @capture.id)
    @favorite.update_attributes(favorite: params[:favorite])
  end

  private
    def set_capture
      @capture = Capture.find(params[:id])
    end

    def capture_params
      params.require(:capture).permit(:name, :comment, :picture, :tag_list, :anime_id)
    end

end

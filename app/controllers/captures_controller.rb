class CapturesController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :set_capture, only: [:show, :edit, :update, :destroy]

  PER_PAGE = 30

  def index
    @captures = Capture.all.order("id desc")
    case params[:serch_type_id].to_i
    when SearchType::TAG.id
      keywords = params[:search_text].split(",")
      @captures = @captures.tagged_with keywords, any: true
    when SearchType::COMMENT.id
      @captures = @captures.where("comment like ?", "%#{params[:search_text]}%")
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
        @capture.generate_message!
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

  private
    def set_capture
      @capture = Capture.find(params[:id])
    end

    def capture_params
      params.require(:capture).permit(:name, :picture, :tag_list, :anime_id)
    end

end

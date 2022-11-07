class MobilesController < ApplicationController
  before_action :set_mobile, only: %i[ show edit update destroy ]
  after_action :count, only: %i[ new edit update destroy ]

  # GET /mobiles or /mobiles.json
  def index
    @mobiles = Mobile.all
  end

  # GET /mobiles/1 or /mobiles/1.json
  def show
    respond_to do |format|
      format.turbo_stream
    end
  end

  # GET /mobiles/new
  def new
    @mobile = Mobile.new
  end

  # GET /mobiles/1/edit
  def edit
  end

  # POST /mobiles or /mobiles.json
  def create
    @mobile = Mobile.new(mobile_params)

    respond_to do |format|
      if @mobile.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("mobile_list", partial: 'mobiles/mobile', locals: {mobile: @mobile}) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: 'mobiles/form_modal', locals: {mobile: @mobile, partial_file: 'form'}) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobiles/1 or /mobiles/1.json
  def update
    respond_to do |format|
      if @mobile.update(mobile_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("mobile_row_#{@mobile.id}", partial: 'mobiles/mobile', locals: {mobile: @mobile}) }
        format.html { redirect_to mobile_url(@mobile), notice: "Mobile was successfully updated." }
        format.json { render :show, status: :ok, location: @mobile }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: 'mobiles/form_modal', locals: {mobile: @mobile, partial_file: 'form'}) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobiles/1 or /mobiles/1.json
  def destroy
    @mobile.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("mobile_row_#{@mobile.id}") }
      format.html { redirect_to mobiles_url, notice: "Mobile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def count
    @count = Mobile.all.count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile
      @mobile = Mobile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mobile_params
      params.require(:mobile).permit(:brand_name, :ram, :rom, :price)
    end

    
end

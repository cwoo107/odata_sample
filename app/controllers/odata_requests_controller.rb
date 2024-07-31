class OdataRequestsController < ApplicationController
  before_action :set_odata_request, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /odata_requests or /odata_requests.json

  # GET /odata_requests/1 or /odata_requests/1.json
  def show
  end

  # GET /odata_requests/new
  def new
    pp params
    @collection = params[:collection]
    @odata_request = OdataRequest.new
  end

  # GET /odata_requests/1/edit
  def edit
  end

  # POST /odata_requests or /odata_requests.json
  def create
    @odata_request = OdataRequest.new(odata_request_params)
    @odata_request.user_id = current_user.id

    respond_to do |format|
      if @odata_request.save
        format.html { redirect_to collection_url(@odata_request.collection), notice: "Odata request was successfully created." }
        format.json { render :show, status: :created, location: @odata_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @odata_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /odata_requests/1 or /odata_requests/1.json
  def update
    respond_to do |format|
      if @odata_request.update(odata_request_params)
        format.html { redirect_to @odata_request, notice: "Odata request was successfully updated." }
        format.json { render :show, status: :ok, location: @odata_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @odata_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /odata_requests/1 or /odata_requests/1.json
  def destroy
    collection = @odata_request.collection
    @odata_request.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@odata_request)}
      format.html { redirect_to collection, notice: "Odata request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_odata_request
      @odata_request = OdataRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def odata_request_params
      params.require(:odata_request).permit(:collection_id, :name, :description, :base_url, :url, :authorization)
    end
end

class SelectFieldsController < ApplicationController
  before_action :set_select_field, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /select_fields or /select_fields.json


  # GET /select_fields/1 or /select_fields/1.json
  def show
  end

  # GET /select_fields/new
  def new
    @odata_request = params[:odata_request]
    @select_field = SelectField.new
  end

  # GET /select_fields/1/edit
  def edit
  end

  # POST /select_fields or /select_fields.json
  def create
    @select_field = SelectField.new(select_field_params)

    respond_to do |format|
      if @select_field.save
        format.html { redirect_to @select_field.odata_request, notice: "Select field was successfully created." }
        format.json { render :show, status: :created, location: @select_field }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @select_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /select_fields/1 or /select_fields/1.json
  def update
    respond_to do |format|
      if @select_field.update(select_field_params)
        format.html { redirect_to @select_field.odata_request, notice: "Select field was successfully updated." }
        format.json { render :show, status: :ok, location: @select_field }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @select_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /select_fields/1 or /select_fields/1.json
  def destroy
    odata_request = @select_field.odata_request
    @select_field.destroy

    respond_to do |format|
      format.html { redirect_to odata_request, notice: "Select field was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_select_field
      @select_field = SelectField.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def select_field_params
      params.require(:select_field).permit(:field_name, :odata_request_id)
    end
end

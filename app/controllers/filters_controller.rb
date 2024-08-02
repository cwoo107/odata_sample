class FiltersController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_filter, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /filters or /filters.json

  # GET /filters/1 or /filters/1.json
  def show
  end

  # GET /filters/new
  def new
    @filter = Filter.new
  end

  # GET /filters/1/edit
  def edit
  end

  # POST /filters or /filters.json
  def create
    @filter = Filter.new(filter_params)
    puts "It didn't hit the save state"

    respond_to do |format|
      if @filter.save
        puts "It hit the save state"
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@filter.filter_group), partial: 'filter_groups/filter_group', locals: { filter_group: @filter.filter_group})}
        format.html { redirect_to @filter.filter_group.odata_request, notice: "Filter was successfully created." }
        format.json { render :show, status: :created, location: @filter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
        pp @filter.errors
      end
    end
  end

  # PATCH/PUT /filters/1 or /filters/1.json
  def update
    respond_to do |format|
      if @filter.update(filter_params)
        format.html { redirect_to filter_url(@filter), notice: "Filter was successfully updated." }
        format.json { render :show, status: :ok, location: @filter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filters/1 or /filters/1.json
  def destroy
    @filter.destroy!

    respond_to do |format|
      format.turbo_stream { render(turbo_stream: turbo_stream.remove(dom_id(@filter))) }
      format.html { redirect_to odata_request, notice: "Filter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filter
      @filter = Filter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filter_params
      params.require(:filter).permit(:filter_group_id, :filter_field, :operator, :filter_value, :built_filter)
    end
end

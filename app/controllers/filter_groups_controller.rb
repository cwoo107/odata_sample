class FilterGroupsController < ApplicationController
  before_action :set_filter_group, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  include ActionView::RecordIdentifier

  # GET /filter_groups or /filter_groups.json

  # GET /filter_groups/1 or /filter_groups/1.json
  def show
  end

  # GET /filter_groups/new
  def new
    @filter_group = FilterGroup.new
  end

  # GET /filter_groups/1/edit
  def edit
  end

  # POST /filter_groups or /filter_groups.json
  def create
    @filter_group = FilterGroup.new(filter_group_params)

    respond_to do |format|
      if @filter_group.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("filter_groups_odata_request_#{@filter_group.odata_request_id}", partial: 'filter_groups/filter_group', locals: { filter_group: @filter_group})}
        format.html { redirect_to @filter_group.odata_request, notice: "Filter group was successfully created." }
        format.json { render :show, status: :created, location: @filter_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @filter_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filter_groups/1 or /filter_groups/1.json
  def update
    respond_to do |format|
      if @filter_group.update(filter_group_params)
        format.html { redirect_to filter_group_url(@filter_group), notice: "Filter group was successfully updated." }
        format.json { render :show, status: :ok, location: @filter_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @filter_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filter_groups/1 or /filter_groups/1.json
  def destroy
    odata_request = @filter_group.odata_request

    @filter_group.destroy
    respond_to do |format|
      format.turbo_stream { render(turbo_stream: turbo_stream.remove(dom_id(@filter_group))) }
      format.html { redirect_to odata_request, notice: "Filter group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filter_group
      @filter_group = FilterGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filter_group_params
      params.require(:filter_group).permit(:odata_request_id, :built_filter_group)
    end
end

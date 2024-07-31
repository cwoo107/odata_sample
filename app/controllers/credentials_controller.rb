class CredentialsController < ApplicationController
  before_action :set_credential, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :validate_user, only: %i[ show edit update destroy ]

  # GET /credentials or /credentials.json
  def index
    @credentials = Credential.where(user_id: current_user.id)
  end

  # GET /credentials/1 or /credentials/1.json
  def show
  end

  # GET /credentials/new
  def new
    @collection = params[:collection]
    @credential = Credential.new
  end

  # GET /credentials/1/edit
  def edit
  end

  # POST /credentials or /credentials.json
  def create
    @credential = Credential.new(credential_params)
    @credential.user_id = current_user.id

    respond_to do |format|
      if @credential.save
        format.html { redirect_to @credential.collection, notice: "Credential was successfully created." }
        format.json { render :show, status: :created, location: @credential }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credentials/1 or /credentials/1.json
  def update
    respond_to do |format|
      if @credential.update(credential_params)
        format.html { redirect_to @credential.collection, notice: "Credential was successfully updated." }
        format.json { render :show, status: :ok, location: @credential }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credentials/1 or /credentials/1.json
  def destroy
    collection = @credential.collection
    @credential.destroy

    respond_to do |format|
      format.html { redirect_to collection, notice: "Credential was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credential
      @credential = Credential.find(params[:id])
    end

  def validate_user
    if @credential.user_id != current_user.id
      redirect_to root_path
    end
  end

    # Only allow a list of trusted parameters through.
    def credential_params
      params.require(:credential).permit(:user_id, :username, :password, :collection_id)
    end
end

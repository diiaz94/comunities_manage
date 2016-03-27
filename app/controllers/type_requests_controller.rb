class TypeRequestsController < ApplicationController
  before_action :validate_authentication
  before_action :validate_admin_access  
  before_action :set_type_request, only: [:show, :edit, :update, :destroy]

  # GET /type_requests
  # GET /type_requests.json
  def index
    @type_requests = TypeRequest.all
  end

  # GET /type_requests/1
  # GET /type_requests/1.json
  def show
  end

  # GET /type_requests/new
  def new
    @type_request = TypeRequest.new
  end

  # GET /type_requests/1/edit
  def edit
  end

  # POST /type_requests
  # POST /type_requests.json
  def create
    @type_request = TypeRequest.new(type_request_params)

    respond_to do |format|
      if @type_request.save
        format.html { redirect_to @type_request, notice: 'Type request was successfully created.' }
        format.json { render :show, status: :created, location: @type_request }
      else
        format.html { render :new }
        format.json { render json: @type_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_requests/1
  # PATCH/PUT /type_requests/1.json
  def update
    respond_to do |format|
      if @type_request.update(type_request_params)
        format.html { redirect_to @type_request, notice: 'Type request was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_request }
      else
        format.html { render :edit }
        format.json { render json: @type_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_requests/1
  # DELETE /type_requests/1.json
  def destroy
    @type_request.destroy
    respond_to do |format|
      format.html { redirect_to type_requests_url, notice: 'Type request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_request
      @type_request = TypeRequest.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_request_params
      params.require(:type_request).permit(:nombre, :formato)
    end
end

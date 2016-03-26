class StatusRequestsController < ApplicationController
  before_action :validate_authentication  
  before_action :set_status_request, only: [:show, :edit, :update, :destroy]

  # GET /status_requests
  # GET /status_requests.json
  def index
    @status_requests = StatusRequest.all
  end

  # GET /status_requests/1
  # GET /status_requests/1.json
  def show
  end

  # GET /status_requests/new
  def new
    @status_request = StatusRequest.new
  end

  # GET /status_requests/1/edit
  def edit
  end

  # POST /status_requests
  # POST /status_requests.json
  def create
    @status_request = StatusRequest.new(status_request_params)

    respond_to do |format|
      if @status_request.save
        format.html { redirect_to @status_request, notice: 'Status request was successfully created.' }
        format.json { render :show, status: :created, location: @status_request }
      else
        format.html { render :new }
        format.json { render json: @status_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /status_requests/1
  # PATCH/PUT /status_requests/1.json
  def update
    respond_to do |format|
      if @status_request.update(status_request_params)
        format.html { redirect_to @status_request, notice: 'Status request was successfully updated.' }
        format.json { render :show, status: :ok, location: @status_request }
      else
        format.html { render :edit }
        format.json { render json: @status_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /status_requests/1
  # DELETE /status_requests/1.json
  def destroy
    @status_request.destroy
    respond_to do |format|
      format.html { redirect_to status_requests_url, notice: 'Status request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status_request
      @status_request = StatusRequest.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_request_params
      params.require(:status_request).permit(:nombre)
    end
end

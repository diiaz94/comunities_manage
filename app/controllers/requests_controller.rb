class RequestsController < ApplicationController
  before_action :validate_authentication
  before_action :validate_member_access, only: [:edit]  
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_profiles, only: [:index, :new,:edit, :update]
  before_action :set_comunities, only: [:index, :new,:edit, :update]
  before_action :set_types_requests, only: [:index, :new,:edit, :update]
  before_action :set_status_requests, only: [:index, :new,:edit, :update]

  after_action :set_date_created_at, only: [:create]
  after_action :set_date_updated_at, only: [:update]
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
    @request = Request.new
    getCurrentTime
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    if session[:type_user]=="SimpleUser"
      @request.profile_id = current_user.profile_id
      @request.comunity_id = current_user.profile.family.comunity_id
      @request.status_request_id = StatusRequest.where(nombre: "Pendiente")[0].id
    end
    respond_to do |format|
      if @request.save
        if session[:type_user]=="SimpleUser"
          format.html { redirect_to @request, notice: 'La solicitud fue creada exitosamente.' }
        else
          format.html { redirect_to  requests_path, notice: 'La solicitud fue creada exitosamente.' }
        end
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        if session[:type_user]=="SimpleUser"
          format.html { redirect_to @request, notice: 'La solicitud fue actualizada exitosamente.' }
        else
          format.html { redirect_to requests_path, notice: 'La solicitud fue actualizada exitosamente.' }
        end
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'La solicitud fue eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.friendly.find(params[:id])
    end
    def set_profiles
      @profiles = Profile.all
    end
    def set_comunities
      @comunities = Comunity.all
    end
    def set_types_requests
      @types_requests = TypeRequest.all
    end
    def set_status_requests
      @status_requests = StatusRequest.all
    end
    def set_date_created_at
      time = getCurrentTime
      @request.created_at = time ? time : Date.today
      @request.save
    end
    def set_date_updated_at
      time = getCurrentTime
      @request.updated_at = time ? time : Date.today
      @request.save
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:profile_id,:comunity_id,:status_request_id,:type_request_id,:motive)
    end
end

class MembersController < ApplicationController
  before_action :validate_authentication
  before_action :validate_admin_access
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :set_comunities, only: [:index, :new,:edit, :update]  
  before_action :set_profiles, only: [:index, :new,:edit, :update]  
  before_action :set_jobs, only: [:index, :new,:edit, :update]  
  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.friendly.find(params[:id])
    end
    def set_comunities
      @comunities = Comunity.all
    end
    def set_profiles
      @profiles = Profile.all
    end
    def set_jobs
      @jobs = Job.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:profile_id, :comunity_id, :job_id)
    end
end

class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show

    puts params.to_s
  end

  # GET /searches/new
  def new
    @search = Search.new
  end
  
  def buscar
    text = params["text"].downcase
    profiles =  Profile.all
    families = Family.all

    @profiles=[]
    @families=[]

    for i in 0..profiles.length-1
      if (session[:type_user]=="SimpleUser" and current_user.profile.family.id==profiles[i].family.id ) or 
         (session[:type_user]=="Miembro" and current_user.profile.member.comunity.id==profiles[i].family.comunity.id) or
         (session[:type_user]=="Administrador")
        if profiles[i].cedula.index(text) or
          profiles[i].primer_nombre.downcase.index(text) or            
          profiles[i].segundo_nombre.downcase.index(text) or            
          profiles[i].primer_apellido.downcase.index(text) or            
          profiles[i].segundo_apellido.downcase.index(text) or            
          profiles[i].telefono.index(text) or            
          profiles[i].email.index(text)            
            
            @profiles.push(profiles[i])
          end
      end      
    end
    for i in 0..families.length-1
      if (session[:type_user]=="SimpleUser" and current_user.profile.family.id==families[i].id ) or 
         (session[:type_user]=="Miembro" and current_user.profile.member.comunity.id==families[i].comunity.id) or
         (session[:type_user]=="Administrador")
        if  families[i].nombre_casa.downcase.index(text) or            
            families[i].numero_casa.downcase.index(text) or            
            families[i].telefono.downcase.index(text) or            
            families[i].direccion.downcase.index(text)              
            @families.push(families[i])
          end
      end      
    end

    render 'searching'
  end
  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:text)
    end
end

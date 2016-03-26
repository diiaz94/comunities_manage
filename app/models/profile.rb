class Profile < ActiveRecord::Base
	belongs_to :family
	has_one :member
	has_one :user
  has_many :requests
 	extend FriendlyId
	friendly_id :cedula, use: :slugged

  FOTOS = File.join Rails.root, 'public','photo_store'

  after_save :guardar_foto


  def photo=(file_data)
     puts "FILE DATASIZE********"+file_data.size.to_s
    if !file_data.blank?
      @file_data = file_data
      @extension = file_data.original_filename.split('.').last.downcase
    end
  end

  def photo_filename
  	File.join FOTOS, "#{cedula}.jpg"
  end
  
  def photo_path
  	"/photo_store/#{cedula}.jpg"
  end
  
  def has_photo?
  	File.exists? photo_filename
  end

  def ruta_photo
  	if has_photo?
  		self.photo_path
  	else
  		"/photo_store/default.jpg"
  	end
  end
  def email_mask
    if self.email.length<23
      self.email
    else
      self.email[0,20]+"..."
    end
  end

  def mask_date(fecha)
    $months=$months?$months:$months=["Enero","Febrero",
                                    "Marzo","Abril",
                                    "Mayo","Junio",
                                    "Julio","Agosto",
                                    "Septiembre","Octubre",
                                    "Noviembre","Diciembre"]
    fecha[8,2]+" de "+$months[fecha[5,2].to_i-1] + " de " + fecha[0,4]
  end

  def antiguedad
    return Date.today.year - self.fecha_ing.year
  end

  def cedula_format
    c = self.cedula
    p=(c.length/3).to_i
    r=""
    index = c.length - 3
    count = c.length
    #puts count.to_s+"hereee"+index.to_s
    while p>0
      r="."+c[index,3]+r
      index=index-3
      p=p-1
    end
    if (index+3)>0
      r=c[0,index+3]+r
    end
    return r
  end

  def telefono_format
    c=self.telefono
    if(c.length==11)
      c[0,4]+"-"+c[4,3]+"-"+c[7,2]+"-"+c[9,2]
    else
      c
    end
  end
  def nombre_completo(l)
    n = self.primer_nombre+" "+self.segundo_nombre+" "+self.primer_apellido+" "+self.segundo_apellido

    if n.length >l
      n[0,l-3]+'...'
    else
      n
    end  
    
  end

  def edad
    if (Date.today.month<self.fecha_nac.month or (Date.today.month==self.fecha_nac.month and Date.today.day<self.fecha_nac.day))
      Date.today.year - self.fecha_nac.year - 1
    else
      return Date.today.year - self.fecha_nac.year
    end
  end

  def nombreCasa
    if(self.family==nil)
      return "Sin Asignar"
    else
      return self.family.nombre_casa
    end 
  end
  
  private
  def guardar_foto
    if @file_data
      
      FileUtils.mkdir_p FOTOS
      File.open(photo_filename, 'wb') do |f|
        f.write(@file_data.read)
      end
      @file_data = nil
    end
  end
end

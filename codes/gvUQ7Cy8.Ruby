  # Method POST
  # Reçoit l'id d'un candidat
  # Génére la fiche candidat
  def generate
    @candidat = Candidat.find(params[:id])

    report = ODFReport::Report.new("/opt/intranet/public/fiche_candidat_template.odt") do |r|
      r.add_field :lastname, @candidat.lastname
      r.add_field :firstname, @candidat.firstname
      r.add_field :birthday_date, @candidat.age
      # Pour la ville, on commence par capitalize pour passer en minuscule les caractères spéciaux
      # que titleize n'arrive pas à gérer
      r.add_field :city, @candidat.city
      r.add_field :zip_code, @candidat.zip_code
      r.add_field :telephone, @candidat.telephone
      r.add_field :mobile, @candidat.mobile
      r.add_field :email, @candidat.email
      r.add_field :email_pro, @candidat.email_pro
      r.add_field :wish_rem_brut, @candidat.candidat_extra.wish_rem_brut
      r.add_field :note, @candidat.comments
      r.add_field :date, @candidat.created_at.strftime('%d/%m/%Y')

      list_langue = ""
      @candidat.candidat_languages.each do |langue|
        list_langue << "#{langue.language.libelle} : #{langue.level}\n"
      end
      r.add_field :language, list_langue

      list_location = ""
      @candidat.candidat_locations.each do |location|
        list_location << "#{location.location.name}\n"
      end
      r.add_field :mobility, list_location

      file_photo = @candidat.attachments.find(:first, :conditions => "name like 'Photo_#{@candidat.firstname.gsub(/ +/,'_')}_#{@candidat.lastname.gsub(/ +/,'_')}_#{@candidat.id.to_s}' AND candidat_id = #{@candidat.id.to_s}")
      unless file_photo.nil?
        nom_photo = file_photo.name + "." + file_photo.extension
        r.add_image :photo, "#{STOCK_ATHENA_DIR[:general]}/pi/#{nom_photo}"
      end
    end
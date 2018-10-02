class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
	#before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
  #after_action :resolve_new, only: [:new]

  protected

  def resolve_new(colab)
    entrou = false
    ldap = Net::LDAP.new(
      host: '10.44.2.22',
      port: 389,
      base: "CN=Adm UNIVASF SAHU,OU=Administradores,OU=Usuarios,OU=HEWAB,OU=EBSERH,dc=EBSERHNET,dc=EBSERH,dc=GOV,dc=BR",
      auth: { method: :simple, username: 'adm.univasfsahu' + '@ebserhnet.ebserh.gov.br', password:'sgpti@2016' }
      )
      treebase = "dc=EBSERHNET,dc=EBSERH,dc=GOV,dc=BR"
      filter = Net::LDAP::Filter.eq( "name", "Adm "+colab ) | Net::LDAP::Filter.eq( "name", colab )
      attrs = %w[ sAMAccountName name]
      ldap.search( base: treebase, filter: filter, attributes: attrs, return_result: true ) do |entry|
        entrou = true
        puts "entrou"
        puts "#{entry.sAMAccountName}"
        puts "#{entry.name}"
        name = entry.name.first.to_s
        un = entry.sAMAccountName.first.to_s
        puts colab.titleize
        if name.start_with?("Adm " || "adm ")
          colab = name[4..-1]
          user = User.new(nome: colab.titleize, username: un , password: "sgpti2018", admin: true, sign_in_count: 2)
          user.save!
        else
          user = User.new(nome: colab.titleize, username: un , password: "sgpti2018", sign_in_count: 2)
          user.save!
        end
        break
      end
      if entrou == false
        user = User.new(nome: colab, username: "colab" , password: "sgpti2018")
        user.save!
      end
  end

  def after_sign_in_path_for(user)
    if user.admin? && user.sign_in_count == 1
      list = List.new(setor: nil)
      list.save!
      user.update!(sign_in_count: 3)
      list.colabs.create!(nome: nil)
      list.telefones.create!(telefone: nil)
    end

    if user.sign_in_count == 1
      list = List.new(setor: nil)
      list.save!
      nome = user.nome
      user.update!(sign_in_count: 2)
      list.colabs.create!(nome: nome)
      list.telefones.create!(telefone: nil)
    else
       root_path
    end
    if user.sign_in_count == 2
      edit_list_path (current_user)
    else
       root_path
    end
  end
  

  def configure_permitted_parameters
    added_attrs = [:nome, :username, :email, :password, :password_confirmation, :remember_me, :admin]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

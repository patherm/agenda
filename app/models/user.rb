class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  #before_create :cadastre
  #COLABS = ""
  before_create :get_ldap_name
  #before_update :get_ldap_name
  after_update :get_ldap_json
# has_one :list
# validates_associated :list

  	def email_required?
    	false
  	end

require 'net/ldap'
    def get_ldap_name
      name_for_login(username, password)
    end

    def name_for_login (username, password)
      entrou = false
      ldap = Net::LDAP.new(
      host: '10.44.2.22',
      port: 389,
      base: "CN=Adm UNIVASF SAHU,OU=Administradores,OU=Usuarios,OU=HEWAB,OU=EBSERH,dc=EBSERHNET,dc=EBSERH,dc=GOV,dc=BR",
      auth: { method: :simple, username: username + '@ebserhnet.ebserh.gov.br', password:password }
      )
      treebase = "OU=Administradores,OU=Usuarios,OU=HEWAB,OU=EBSERH,dc=EBSERHNET,dc=EBSERH,dc=GOV,dc=BR"
      filter = Net::LDAP::Filter.eq( "sAMAccountName", username )
      attrs = %w[ name ]
      
      if entrou == false
        treebase = "dc=EBSERHNET,dc=EBSERH,dc=GOV,dc=BR"
        ldap.search( base: treebase, filter: filter, attributes: attrs, return_result: true ) do |entry|
         #puts "#{entry.name}"
          name = entry.name.first.to_s
            self.nome = name
          break
        end
      end
end


  def get_ldap_json
    count = 0
    if self.admin?
      puts "Loading Json File..."
      data = File.open("#{Rails.root}/public/colabs.json", "w+") do |fo|
        fo.puts "["
      end
      ldap = Net::LDAP.new(
        host: '10.44.2.22',
        port: 389,
        base: "CN=Adm UNIVASF SAHU,OU=Administradores,OU=Usuarios,OU=HEWAB,OU=EBSERH,dc=EBSERHNET,dc=EBSERH,dc=GOV,dc=BR",
        auth: { method: :simple, username: 'adm.univasfsahu' + '@ebserhnet.ebserh.gov.br', password:'sgpti@2016' }
      )
      treebase = "OU=Usuarios,OU=HEWAB,OU=EBSERH,dc=EBSERHNET,dc=EBSERH,dc=GOV,dc=BR"
      filter = Net::LDAP::Filter.eq( "cn", "*" )
      attrs = %w[ ou  memberOf sAMAccountName cn ]

      ldap.search( base: treebase, filter: filter, attributes: attrs, return_result: true ) do |entry|
        count = count +1
        if count > 130
          name = entry.cn.first.to_s
          data = File.open("#{Rails.root}/public/colabs.json", "a") do |fo|
            fo.puts '"'+name+'"'+','
          end
        end
      end
        data = File.open("#{Rails.root}/public/colabs.json", "a") do |fo|
          fo.puts '""'+']'
          fo.close
        end
    end

end


	def authenticatable_salt
        Digest::SHA1.hexdigest(username)[0,29]
    end
  
end
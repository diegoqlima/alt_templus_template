require 'net/http'

class RaroUtil
  
  def self.to_time_desc(segundos)
    hora = Time.at(segundos).gmtime.strftime("%H")
    minuto = Time.at(segundos).gmtime.strftime("%M")
    segundo = Time.at(segundos).gmtime.strftime("%S")
    
    tempo = ""
    if hora.to_i == 1
      tempo += "#{hora} hora "
    elsif hora.to_i > 1
      tempo += "#{hora} horas "
    end
    
    tempo += "e " if tempo.present? && segundo.to_i == 0
    
    if minuto.to_i == 1
      tempo += "#{minuto} minuto "
    elsif minuto.to_i > 1
      tempo += "#{minuto} minutos "
    end
    
    tempo += "e " if tempo.present? && segundo.to_i > 0
    
    if segundo.to_i == 1
      tempo += "#{segundo} segundo"
    elsif segundo.to_i > 1
      tempo += "#{segundo} segundos"
    end
    tempo.strip
  end
  
  def self.formata_duracao_horas(segundos)
    hours = segundos / (60 * 60)
    minutes = (segundos / 60) % 60
    
    tempo = ""
    if hours.to_i == 1
      tempo += "#{hours.to_s.rjust(2, '0')} hora"
    elsif hours.to_i > 1
      tempo += "#{hours.to_s.rjust(2, '0')} horas"
    end
    
    tempo += " e " if tempo.present? && minutes.to_i > 0
    
    if minutes.to_i == 1
      tempo += "#{minutes.to_s.rjust(2, '0')} minuto"
    elsif minutes.to_i > 1
      tempo += "#{minutes.to_s.rjust(2, '0')} minutos"
    end
    
    tempo
  end
  
  def self.random(size=10)
    "I#{Array.new(size){rand(size)}.join}"
  end
  
  def self.dia_semana?(data)
    !(data.saturday? || data.sunday?)
  end
  
  def self.formata_data(data,formato = "%d/%m/%Y")
    data.present? ? data.strftime(formato) : ""
  end
  
  def self.formata_moeda(valor, unit = "R$")
    ActionController::Base.helpers.number_to_currency(valor.to_f, unit: unit, :separator => ",", :delimiter => ".")
  end
  
  def self.formata_moeda_relatorio(valor, unit = "R$")
    valor = ActionController::Base.helpers.number_to_currency(valor.to_f, unit: unit, :separator => ",", :delimiter => ".")
    valor.gsub(",00", "")
  end
  
  def self.formata_moeda_banco(valor)
    valor.to_s.gsub(".","").gsub(",",".").to_f
  end
  
  def self.formata_numero(valor, precisao)
    ActionController::Base.helpers.number_to_currency(valor.to_f, unit: "", :separator => ",", :delimiter => ".", precision: precisao)
  end
  
  def self.formata_telefone(ddd,telefone)
    tel = ""
    if ddd.present?
      tel += "(#{RaroUtil.somente_numero(ddd)}) "
    end
    if telefone.present?
      tel += "#{RaroUtil.somente_numero(telefone).insert(4,'-')}"
    end
    tel
  end
  
  def self.somente_numero(numero)
    "#{numero}".gsub(/\D/,"")
  end
  
  def self.valid_url?(link, max_redirect = 2)
    valid = false
    link.insert(0, "http://") unless link.match(/^http:\/\//).present?
    x = 0
    loop do
      url = URI.parse(link)
      break if x > max_redirect 
      requisicao = Net::HTTP.new(url.host, url.port)
      path = url.path.present? ? url.path : '/'
      resposta = requisicao.request_head(path)
      if resposta.kind_of?(Net::HTTPRedirection)
        link = resposta['location']
      else
        valid = true unless %W(4 5).include? resposta.code[0]
        break
      end
      x += 1
    end
    valid
  rescue
    false
  end
  
end
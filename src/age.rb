module Observable
  attr_accessor :interesados

  def interesados
    @interesados = @interesados || []
    @interesados
  end

  def nuevo_interesado(interesado)
    self.interesados << interesado
  end

  def notificar
    self.interesados.each { |interesado|
      interesado.call(self)
    }
  end
end

module Defensor
  include Observable
  attr_accessor :energia, :potencial_defensivo

  def sufri_danio(danio)
    self.energia= self.energia - danio
    self.notificar
  end

  def descansar
    @energia += 10
  end
end

module Atacante
  attr_accessor :potencial_ofensivo

  def atacar(un_defensor)
    if self.potencial_ofensivo > un_defensor.potencial_defensivo
      danio = self.potencial_ofensivo - un_defensor.potencial_defensivo
      un_defensor.sufri_danio(danio)
    end
    @descansado = false
  end

  def potencial_ofensivo
    # nil en ruby evalua es false
    @descansado ? @potencial_ofensivo * 2 : @potencial_ofensivo
  end

  def descansar
    @descansado = true
  end
end

class Guerrero
  include Defensor
  alias_method :descansar_defensor, :descansar
  include Atacante
  alias_method :descansar_atacante, :descansar

  def initialize(potencial_ofensivo = 20, energia = 100, potencial_defensivo = 10)
    self.potencial_ofensivo = potencial_ofensivo
    self.energia = energia
    self.potencial_defensivo = potencial_defensivo
  end

  def descansar
    descansar_atacante
    descansar_defensor
  end
end

class Espadachin < Guerrero
  attr_accessor :espada

  #constructor
  def initialize(espada)
    super(20, 100, 2)
    self.espada= espada
  end

  def potencial_ofensivo
    super + self.espada.potencial_ofensivo
  end
end

class Espada
  attr_accessor :potencial_ofensivo

  def initialize(potencial_ofensivo)
    self.potencial_ofensivo= potencial_ofensivo
  end
end

class Canion
  include Atacante

  def initialize
    self.potencial_ofensivo = 200
  end
end

class Muralla
  include Defensor

  def initialize
    self.energia = 200
    self.potencial_defensivo = 50
  end
end

class Kamikaze
  include Defensor
  include Atacante

  def initialize
    self.energia = 100
    self.potencial_ofensivo = 250
    self.potencial_defensivo = 30
  end

  def atacar(un_defensor)
    super
    self.energia = 0
  end
end

class Mago
  attr_accessor :teletransportando

  def initialize
    @teletransportando = []
  end

  def curar(unidad)
    unidad.energia += 20
  end

  def teletransportar(unidad)
    @teletransportando << unidad
  end

  def lastimaron_a(unidad)
    self.curar(unidad)
  end
end

class Ejercito
  attr_accessor :retirandose, :estrategia

  def self.cobarde
    ejercito = Ejercito.new
    ejercito.estrategia = proc { |defensor|
      ejercito.retirandose = true
    }
    ejercito
  end

  def self.descansador
    ejercito = Ejercito.new
    ejercito.estrategia = proc { |defensor|
      defensor.descansar
    }
    ejercito
  end

  def initialize
    self.retirandose = false
  end

  def add(defensor)
    defensor.nuevo_interesado(self.estrategia)
  end

end
module Observable
  attr_accessor :interesados

  def agregar_interesado(interesado)
    self.interesados << interesado
  end

  def interesados
    @interesados = @interesados || []
  end

  def notificar_todos
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
    self.notificar_todos
  end

  def descansar
    self.energia += 10
  end
end

module Atacante
  attr_accessor :potencial_ofensivo

  def atacar(un_defensor)
    if self.potencial_ofensivo > un_defensor.potencial_defensivo
      danio = self.potencial_ofensivo - un_defensor.potencial_defensivo
      un_defensor.sufri_danio(danio)
    end
    @multiplicador = 1
  end

  def potencial_ofensivo
    @potencial_ofensivo * self.multiplicador
  end

  def descansar
    @multiplicador = 2
  end

  def multiplicador
    @multiplicador = @multiplicador || 1
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
    self.descansar_atacante
    self.descansar_defensor
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
    self.potencial_ofensivo = potencial_ofensivo
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
    @potencial_ofensivo = 250
    @energia = 100
    @potencial_defensivo = 10
  end

  def atacar(un_defensor)
    super(un_defensor)
    @energia = 0
  end
end

class Ejercito
  attr_accessor :retirado, :accion_a_tomar

  def self.cobarde
    ejercito = Ejercito.new(
        proc { |unidad|
          ejercito.retirate
        })
    ejercito
  end

  def self.descansador
    Ejercito.new(
        proc { |unidad|
          unidad.descansar
        })
  end

  def initialize accion_a_tomar
    @retirado = false
    @accion_a_tomar = accion_a_tomar
  end

  def add(unidad)
    unidad.agregar_interesado(self.accion_a_tomar)
  end

  def retirate
    @retirado = true
  end
end

class Mago
  attr_accessor :teletransportados, :magia

  def initialize
    @teletransportados = []
    @magia = 100
  end

  def notificar(unidad)
    self.curar(unidad)
  end

  def curar(unidad)
    unidad.energia += 20
    @magia -= 5
  end

  def teletransportar(unidad)
    @teletransportados << unidad
    @magia -= 20
  end

end
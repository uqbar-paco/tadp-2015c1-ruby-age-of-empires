module Defensor
  attr_accessor :energia, :potencial_defensivo

  def sufri_danio(danio)
    self.energia= self.energia - danio
  end

end

module Atacante
  attr_accessor :potencial_ofensivo

  def atacar(un_defensor)
    if self.potencial_ofensivo > un_defensor.potencial_defensivo
      danio = self.potencial_ofensivo - un_defensor.potencial_defensivo
      un_defensor.sufri_danio(danio)
    end
  end

end

class Guerrero
  include Defensor
  include Atacante

  def initialize(potencial_ofensivo=20, energia=100, potencial_defensivo=10)
    self.potencial_ofensivo = potencial_ofensivo
    self.energia = energia
    self.potencial_defensivo = potencial_defensivo
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
    super() + self.espada.potencial_ofensivo
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
    self.energia =200
    self.potencial_defensivo = 50
  end
end
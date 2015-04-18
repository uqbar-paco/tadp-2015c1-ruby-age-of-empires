require 'rspec'
require_relative '../src/age'

describe 'age of empires tests' do
  #Los guerreros tienen estos parámetros por default: potencial_ofensivo=20, energia=100, potencial_defensivo=10
  it 'vikingo ataca a atila' do
    atila = Guerrero.new
    vikingo = Guerrero.new 70

    vikingo.atacar atila
    expect(atila.energia).to eq(40)
  end

  it 'espadachin ataca a atila' do
    atila = Guerrero.new
    don_quijote = Espadachin.new(Espada.new(50))

    don_quijote.atacar atila
    expect(atila.energia).to eq(40)
  end

  it 'atila ataca a vikingo pero no le hace danio' do
    atila = Guerrero.new
    vikingo = Guerrero.new 70

    atila.atacar vikingo
    expect(atila.energia).to eq(100)
  end

  it 'Muralla solo defiende' do
    muralla = Muralla.new
    vikingo = Guerrero.new 70

    vikingo.atacar(muralla)
    expect(muralla.energia).to eq(180)
    vikingo.atacar(muralla)
    expect(muralla.energia).to eq(160)
  end

  it 'Canion Ataca a Muralla' do
    muralla = Muralla.new
    canion = Canion.new

    canion.atacar muralla
    expect(muralla.energia).to eq(50)
  end

  it 'Muralla no ataca' do
    muralla = Muralla.new
    don_quijote = Espadachin.new(Espada.new(40))
    #Esto es la manera sintáctica de decir que lo que se espera dentro de los {} del expect, lanza una exception.
    #Despues veremos que quieren decir los {}
    expect { muralla.atacar don_quijote }.to raise_error(NoMethodError)
  end

  it 'Canion no defiende' do
    canion = Canion.new
    don_quijote = Espadachin.new(Espada.new(40))
    expect { don_quijote.atacar canion }.to raise_error(NoMethodError)
  end

  #########################

  it 'atacante descansado pega doble' do
    atila = Guerrero.new #(potencial_ofensivo = 20, energia = 100, potencial_defensivo = 10)
    conan = Guerrero.new

    atila.descansar
    atila.atacar conan

    # 100 - (20 * 2 - 10)
    expect(conan.energia).to eq(70)
  end

  it 'atacante descansado ataca doble solo una vez por descanso' do
    atila = Guerrero.new
    conan = Guerrero.new
    heman = Guerrero.new

    atila.descansar
    atila.atacar conan
    atila.atacar heman

    # 100 - (20 - 10)
    expect(heman.energia).to eq(90)
  end

  it 'defensor descansado suma 10' do
    muralla = Muralla.new
    expect(muralla.energia).to eq(200)

    muralla.descansar

    expect(muralla.energia).to eq(210)
  end

  it 'guerrero descansa como defensor y como atacante' do
    atila = Guerrero.new
    conan = Guerrero.new

    expect(atila.energia).to eq(100)
    atila.descansar
    atila.atacar conan

    expect(conan.energia).to eq(70)
    expect(atila.energia).to eq(110)
  end

  ###################

  it 'kamikaze pierde su energia luego de atacar' do
    kamikaze = Kamikaze.new
    muralla = Muralla.new

    kamikaze.atacar(muralla)

    expect(muralla.energia).to eq(0)
    expect(kamikaze.energia).to eq(0)
  end

  it 'kamikaze descansa solo como atacante' do
    kamikaze = Kamikaze.new
    atila = Guerrero.new

    expect(kamikaze.potencial_ofensivo).to eq(250)

    kamikaze.descansar
    expect(kamikaze.energia).to eq(100)
    expect(kamikaze.potencial_ofensivo).to eq(500)

    kamikaze.atacar(atila)
    expect(kamikaze.energia).to eq(0)
  end

  it 'ejercito cobarde se retira' do
    atila = Guerrero.new

    konan = Guerrero.new
    ejercito = Ejercito.cobarde # crea un ejercito cobarde
    ejercito.add(konan)

    expect(ejercito.retirado).to be(false)
    atila.atacar(konan)
    expect(ejercito.retirado).to be(true)
  end

  it 'ejercito descansador descansa a la unidad' do
    atila = Guerrero.new

    konan = Guerrero.new
    ejercito = Ejercito.descansador
    ejercito.add(konan)

    expect(konan.energia).to eq(100)
    atila.atacar(konan)
    expect(konan.energia).to eq(100)
    expect(ejercito.retirado).to be(false)
  end

  it 'mago puede curar guerrero' do
    atila = Guerrero.new

    konan = Guerrero.new
    mago = Mago.new
    konan.agregar_interesado(proc { |unidad|
                               mago.curar(unidad)
                             })

    expect(konan.energia).to eq(100)
    atila.atacar(konan)
    expect(konan.energia).to eq(110)
  end

  it 'mago puede teletransportar' do
    atila = Guerrero.new

    konan = Guerrero.new
    mago = Mago.new
    konan.agregar_interesado(
        proc { |unidad|
          mago.teletransportar(unidad)
        })

    atila.atacar(konan)
    expect(mago.teletransportados.include?(konan)).to be(true)
    expect(mago.teletransportados).to include(konan)
  end

  #Metaprogramacion

  it 'mago puede teletransportar usando un metodo' do
    atila = Guerrero.new

    konan = Guerrero.new
    mago = Mago.new
    konan.agregar_interesado(mago.method(:teletransportar))

    atila.atacar(konan)
    expect(mago.teletransportados.include?(konan)).to be(true)
    expect(mago.teletransportados).to include(konan)
  end

  it 'cuando atila es atacado pasan cosas locas' do
    atila = Guerrero.new

    atila
        .singleton_class.send(:define_method, :comerse_un_pollo, proc {
                                              self.energia += 20
                                            })

    atila.agregar_interesado(proc { |unidad|
                               unidad.descansar # +10
                               unidad.comerse_un_pollo # +20
                             })

    conan = Guerrero.new
    conan.atacar(atila)

    expect(atila.energia).to eq(100 - 10 + 10 + 20)
  end

end
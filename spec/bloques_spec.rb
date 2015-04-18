require 'rspec'

describe 'Referencias en bloques' do

  it 'cambiar valor variable fuera del bloque' do
    a = 5
    bloque = proc {
      a
    }

    expect(bloque.call()).to be(5)

    a = 6
    expect(bloque.call()).to be(6)
  end

  it 'cambiar valor de la variable dentro del bloque' do
    a = 5
    bloque = proc {
      a = 3
    }

    expect(a).to be(5)
    bloque.call()
    expect(a).to be(3)
  end

end
require 'rspec'

describe 'Referencias en bloques' do

  class B
    def m(&block)
      block.call
    end
  end

  it 'bloque por parametro' do
    block = proc {
        5
    }
    expect(B.new.m(&block)).to eq(5)
  end

  it 'puedo referenciar variables dentro de las clases' do
    a = 5

    class A
    end

    A.send(:define_method, :m) {
      a
    }

    expect(A.new.m).to eq(5)
  end

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
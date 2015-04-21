require 'rspec'
require_relative '../src/age'

describe 'Versionador' do

  module Versionador
    def version
      @version = @version || 0
    end
    def versionar
      @version = self.version + 1
    end
  end

  Object.include Versionador

  it 'puedo versionar clases' do
    expect(Guerrero.version).to eq(0)
    Guerrero.versionar
    expect(Guerrero.version).to eq(1)
  end

  it 'deberia tener una version' do
    atila = Guerrero.new

    expect(atila.version).to eq(0)
  end

  it 'deberia versionar' do
    atila = Guerrero.new
    atila.versionar

    expect(atila.version).to be(1)
  end

  it 'deberia funcionar tambien para cualquier otra cosa' do
    a_string = 'Hola Mundo'
    expect(a_string.version).to be(0)
    a_string.versionar
    expect(a_string.version).to be(1)
  end

  it 'no lo hace en la clase' do
    konan = Guerrero.new
    atila = Guerrero.new
    atila.versionar

    expect(konan.version).to be(0)
    expect(atila.version).to be(1)

    konan.versionar
    expect(konan.version).to be(1)
    expect(atila.version).to be(1)
  end

end
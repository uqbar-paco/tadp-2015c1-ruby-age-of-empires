require 'rspec'
require_relative '../src/age'

describe 'Versionador' do

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
end
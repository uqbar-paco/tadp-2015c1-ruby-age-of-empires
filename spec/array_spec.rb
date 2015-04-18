require 'rspec'

describe 'Array' do

  class NilError < StandardError
  end

  module ValidaPush
    def push *args
      args.each { |value|
        if value == nil
          raise NilError.new
        end
      }
      super *args
    end
  end

  before(:each) {
    @array = [1]
    @array.extend ValidaPush
  }

  it 'acepta valores distintos de nil' do
    @array.push(2)

    expect(@array).to eq([1, 2])
  end

  it 'rechaza nil' do
    expect { @array.push(nil) }.to raise_error NilError
  end

  it 'rechaza nil si lo encuentra en uno de sus argumentos' do
    expect { @array.push(2, 4, nil) }.to raise_error NilError
  end

  it 'no agrega comportamiento a otros arrays' do
    expect([].push(nil)).to eq([nil])
  end

end
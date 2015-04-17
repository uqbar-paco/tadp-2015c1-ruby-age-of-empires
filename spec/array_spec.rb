require 'rspec'

describe 'Array' do
  it 'should accept non-nils' do
    a =[1]
    a.push(2)
    expect(a).to eq([1,2])
  end

  it 'should reject nils' do
    a = [1]
    expect {a.push(nil)}.to raise_error Exception
  end

  it 'should reject nils in varargs' do
    a = [1]
    expect {a.push(2,4,nil)}.to raise_error Exception
  end

end
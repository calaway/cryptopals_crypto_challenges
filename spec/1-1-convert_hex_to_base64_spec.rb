require 'spec_helper'

describe '1-1' do
  it 'converts hex to base64' do
    hex = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    expected = 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'

    expect(hex_to_base64(hex)).to eq(expected)
  end
end

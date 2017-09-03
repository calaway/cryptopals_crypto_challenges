describe '1-2' do
  it 'converts decimal to binary' do
    hex = '1c0111001f010100061a024b53535009181c'
    decimal = hex_to_decimal(hex)
    expected = '111000000000100010001000000000001111100000001000000010000000000000110000110100000001001001011010100110101001101010000000010010001100000011100'

    expect(decimal_to_binary(decimal)).to eq(expected)
  end

  it 'produce xor combination' do
    operand_hex = '1c0111001f010100061a024b53535009181c'
    operator_hex = '686974207468652062756c6c277320657965'

    operand_binary = hex_to_binary(operand_hex)
    operator_binary = hex_to_binary(operator_hex)

    result_binary = xor(operand_binary, operator_binary)
    result_hex = binary_to_hex(result_binary)

    expected = '746865206b696420646f6e277420706c6179'

    expect(result_hex).to eq(expected)
  end
end

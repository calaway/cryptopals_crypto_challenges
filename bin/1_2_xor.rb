def xor(operand, operator)
  length = [operand.length, operator.length].max
  operand = operand.rjust(length, '0')
  operator = operator.rjust(length, '0')
  operand_bits = operand.chars
  operator_bits = operator.chars

  result_bits = operand_bits.zip(operator_bits).map do |pair_of_bits|
    (pair_of_bits[0].to_i + pair_of_bits[1].to_i) % 2
  end
  result_bits.join
end

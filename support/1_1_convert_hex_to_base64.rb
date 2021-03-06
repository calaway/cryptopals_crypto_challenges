def hex_to_base64(hex)
  decimal = hex_to_decimal(hex)
  decimal_to_base64(decimal)
end

def hex_to_binary(hex)
  decimal = hex_to_decimal(hex)
  decimal_to_binary(decimal)
end

def binary_to_hex(binary)
  decimal = binary_to_decimal(binary)
  decimal_to_hex(decimal)
end

def hex_to_decimal(hex)
  dictionary = { '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
                 '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
                 'a' => 10, 'b' => 11, 'c' => 12, 'd' => 13,
                 'e' => 14, 'f' => 15 }
  hex_digits = hex.chars.reverse
  decimals = hex_digits.map.with_index do |hex_digit, index|
    dictionary[hex_digit] * (16**index)
  end
  decimals.sum
end

def decimal_to_base64_dictionary
  { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F', 6 => 'G',
    7 => 'H', 8 => 'I', 9 => 'J', 10 => 'K', 11 => 'L', 12 => 'M', 13 => 'N',
    14 => 'O', 15 => 'P', 16 => 'Q', 17 => 'R', 18 => 'S', 19 => 'T', 20 => 'U',
    21 => 'V', 22 => 'W', 23 => 'X', 24 => 'Y', 25 => 'Z', 26 => 'a', 27 => 'b',
    28 => 'c', 29 => 'd', 30 => 'e', 31 => 'f', 32 => 'g', 33 => 'h', 34 => 'i',
    35 => 'j', 36 => 'k', 37 => 'l', 38 => 'm', 39 => 'n', 40 => 'o', 41 => 'p',
    42 => 'q', 43 => 'r', 44 => 's', 45 => 't', 46 => 'u', 47 => 'v', 48 => 'w',
    49 => 'x', 50 => 'y', 51 => 'z', 52 => '0', 53 => '1', 54 => '2', 55 => '3',
    56 => '4', 57 => '5', 58 => '6', 59 => '7', 60 => '8', 61 => '9', 62 => '+',
    63 => '/' }
end

def decimal_to_base64(decimal)
  base64 = ''
  until decimal.zero?
    base64 << decimal_to_base64_dictionary[decimal % 64]
    decimal /= 64
  end
  base64.reverse
end

def decimal_to_binary(decimal)
  binary = ''
  until decimal.zero?
    binary << (decimal % 2).to_s
    decimal /= 2
  end
  binary.reverse
end

def decimal_to_hex(decimal)
  dictionary = { 0 => '0', 1 => '1', 2 => '2', 3 => '3', 4 => '4', 5 => '5', 6 => '6',
                 7 => '7', 8 => '8', 9 => '9', 10 => 'a', 11 => 'b', 12 => 'c',
                 13 => 'd', 14 => 'e', 15 => 'f' }
  hex = ''
  until decimal.zero?
    hex << dictionary[decimal % 16]
    decimal /= 16
  end
  hex.reverse
end

def binary_to_decimal(binary)
  bits = binary.chars.reverse
  decimals = bits.map.with_index do |bit, index|
    bit.to_i * (2**index)
  end
  decimals.sum
end

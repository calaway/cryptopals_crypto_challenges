Dir['./support/**/*.rb'].each { |file| require file }

ciphertext_hex = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
ciphertext_binary = hex_to_binary(ciphertext_hex)

puts find_most_likely_single_byte_xor_cipher(ciphertext_binary)

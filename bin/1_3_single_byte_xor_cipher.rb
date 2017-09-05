Dir['./support/**/*.rb'].each { |file| require file }

ciphertext_hex = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
ciphertext_binary = hex_to_binary(ciphertext_hex)

all_plaintexts = letter_to_bite.map do |letter, bite|
  repetitions = (ciphertext_binary.length / 8.0).ceil
  pad = bite * repetitions
  plaintext_bites = xor(ciphertext_binary, pad)
  [letter, bites_to_letters(plaintext_bites)]
end.to_h

max_length = all_plaintexts.map { |plaintext_pair| plaintext_pair[1].length }.max
all_plaintexts = all_plaintexts.select do |_, plaintext|
  plaintext.length == max_length
end

scored_plaintexts = all_plaintexts.map { |plaintext| (plaintext << english_letter_frequency_score(plaintext.last)) }

sorted_plaintexts = scored_plaintexts.sort_by { |scored_plaintext| scored_plaintext[2] }

# sorted_plaintexts = all_plaintexts.sort_by do |plaintext|
#   english_letter_frequency_score(letter_frequencies(plaintext.last))
# end.to_h.values

# require 'pry'; binding.pry
sorted_plaintexts.each { |sorted_plaintext| p sorted_plaintext }

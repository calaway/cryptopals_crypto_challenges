def bite_to_letter
  { '00100000' => ' ', '00100001' => '!', '00100010' => '"', '00100011' => '#', '00100100' => '$',
    '00100101' => '%', '00100110' => '&', '00100111' => '\'', '00101000' => '(', '00101001' => ')',
    '00101010' => '*', '00101011' => '+', '00101100' => ',', '00101101' => '-', '00101110' => '.',
    '00101111' => '/', '00110000' => '0', '00110001' => '1', '00110010' => '2', '00110011' => '3',
    '00110100' => '4', '00110101' => '5', '00110110' => '6', '00110111' => '7', '00111000' => '8',
    '00111001' => '9', '00111010' => ':', '00111011' => ';', '00111100' => '<', '00111101' => '=',
    '00111110' => '>', '00111111' => '?', '01000000' => '@', '01000001' => 'A', '01000010' => 'B',
    '01000011' => 'C', '01000100' => 'D', '01000101' => 'E', '01000110' => 'F', '01000111' => 'G',
    '01001000' => 'H', '01001001' => 'I', '01001010' => 'J', '01001011' => 'K', '01001100' => 'L',
    '01001101' => 'M', '01001110' => 'N', '01001111' => 'O', '01010000' => 'P', '01010001' => 'Q',
    '01010010' => 'R', '01010011' => 'S', '01010100' => 'T', '01010101' => 'U', '01010110' => 'V',
    '01010111' => 'W', '01011000' => 'X', '01011001' => 'Y', '01011010' => 'Z', '01011011' => '[',
    '01011100' => '\\', '01011101' => ']', '01011110' => '^', '01011111' => '_', '01100000' => '`',
    '01100001' => 'a', '01100010' => 'b', '01100011' => 'c', '01100100' => 'd', '01100101' => 'e',
    '01100110' => 'f', '01100111' => 'g', '01101000' => 'h', '01101001' => 'i', '01101010' => 'j',
    '01101011' => 'k', '01101100' => 'l', '01101101' => 'm', '01101110' => 'n', '01101111' => 'o',
    '01110000' => 'p', '01110001' => 'q', '01110010' => 'r', '01110011' => 's', '01110100' => 't',
    '01110101' => 'u', '01110110' => 'v', '01110111' => 'w', '01111000' => 'x', '01111001' => 'y',
    '01111010' => 'z', '01111011' => '{', '01111100' => '|', '01111101' => '}', '01111110' => '~' }
end

def letter_to_bite
  @letter_to_bite ||= bite_to_letter.invert
end

def bites_to_letters(bites)
  plaintext = ''
  until bites.length < 8
    letter = bite_to_letter[bites[0..7]]
    letter.nil? ? break : plaintext << letter
    bites = bites[8..-1]
  end
  plaintext
end

def all_single_character_decodings(ciphertext_binary)
  letter_to_bite.each_with_object({}) do |letter_bite, collection|
    repetitions = (ciphertext_binary.length / 8.0).ceil
    pad = letter_bite[1] * repetitions
    plaintext_bites = xor(ciphertext_binary, pad)
    collection[letter_bite[0]] = bites_to_letters(plaintext_bites)
  end
end

def letter_frequencies(text)
  text = text.downcase.gsub(/[^a-z]/, '')
  point = 100 / text.length.to_f
  text.chars.each_with_object(Hash.new(0)) do |char, frequency|
    frequency[char.downcase] += point
  end
end

def english_letter_frequency_score(text)
  expected_frequencies = { 'a' => 8.167, 'b' => 1.492, 'c' => 2.782, 'd' => 4.253, 'e' => 12.702, 'f' => 2.228, 'g' => 2.015, 'h' => 6.094, 'i' => 6.966, 'j' => 0.153, 'k' => 0.772, 'l' => 4.025, 'm' => 2.406, 'n' => 6.749, 'o' => 7.507, 'p' => 1.929, 'q' => 0.095, 'r' => 5.987, 's' => 6.327, 't' => 9.056, 'u' => 2.758, 'v' => 0.978, 'w' => 2.360, 'x' => 0.150, 'y' => 1.974, 'z' => 0.074 }
  actual_frequencies = letter_frequencies(text)
  expected_frequencies.reduce(0) do |score, expected_frequency|
    score + ((expected_frequency[1] - actual_frequencies[expected_frequency[0]])**2 / expected_frequency[1])
  end
end

def keep_only_longest_strings(texts)
  max_length = texts.map(&:length).max
  texts.find_all do |text|
    text.length == max_length
  end
end

def rank_texts_by_score(texts)
  texts = keep_only_longest_strings(texts)
  texts.map do |text|
    [english_letter_frequency_score(text), text]
  end.sort
end

def find_most_likely_single_byte_xor_cipher(ciphertext_binary)
  all_plaintexts = all_single_character_decodings(ciphertext_binary).values
  rank_texts_by_score(all_plaintexts).first.last
end

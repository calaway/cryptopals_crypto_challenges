describe '1-3' do
  it 'converts a bite to a letter' do
    expect(bite_to_letter['01100001']).to eq('a')
    expect(bite_to_letter['01001101']).to eq('M')
    expect(bite_to_letter['00100001']).to eq('!')
  end

  it 'converts a letter to a bite' do
    expect(letter_to_bite['m']).to eq('01101101')
    expect(letter_to_bite['Z']).to eq('01011010')
    expect(letter_to_bite['?']).to eq('00111111')
  end

  it 'converts bites to letters' do
    bites = '01000100011100100110010101100001011011010010000001100010011010010110011100100001'
    expect(bites_to_letters(bites)).to eq('Dream big!')
  end

  it 'creates a letter frequency hash from a string' do
    message = 'Cooking MC\'s like a pound of bacon'

    actual = letter_frequencies(message)
    expected = { 'o' => 18.52, 'n' => 11.11, 'c' => 11.11, 'a' => 7.41, 'i' => 7.41, 'k' => 7.41, 'u' => 3.7, 'd' => 3.7, 'b' => 3.7, 'p' => 3.7, 'f' => 3.7, 's' => 3.7, 'g' => 3.7, 'm' => 3.7, 'l' => 3.7, 'e' => 3.7 }

    actual.each do |letter, frequency|
      expect(frequency).to be_within(0.01).of(expected[letter])
    end
  end

  it 'keeps only the longest strings' do
    collection = %w[1 12 123 1234 abc abcd 4321]

    expect(keep_only_longest_strings(collection)).to eq(%w[1234 abcd 4321])
  end
end

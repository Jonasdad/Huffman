defmodule Huffman do
  def sample() do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'ABCA'
  end

  def test() do
    sample = text()
    _tree = tree(sample)
    #encode = encode_table(tree)
    #decode = decode_table(tree)
    #text = text()
    #seq = encode(text, encode)
   # decode(seq, decode)
  end

  def tree(sample) do
    freqList = freq(sample)
    huffman_tree(freqList |> List.keysort(1))
  end


  # Två metoder: huffman_tree och insert
  # huffman tree bygger trädet
  # build sätter rätt löv och noder på rätt plats
  def huffman_tree([{tree, _n}]) do tree end
  def huffman_tree([{char1, freq1}, {char2, freq2} | t]) do huffman_tree(build({{char1, char2}, freq1+freq2}, t)) end
  def build({char, freq}, []) do [{char,freq}] end
  def build({char1,freq1}, [{char2,freq2} | t]) do
    if(freq1 < freq2) do [{char1, freq1}, {char2, freq2} | t]; else[{char2, freq2} | build({char1, freq1}, t)] end
  end

  def compress({left, right}) do compress({left, right}, []) end
  def compress({left, right}, sequence) do

  end
  #def encode_table(tree) do
    # To implement...
  #end

  #def decode_table(tree) do
    # To implement...
  #end

  #def encode(text, table) do
    # To implement...
  #end

  #def decode(seq, tree) do
    # To implement...
  #end

  # Initial call of freq/1 to initiate freq/2 using only the sample text
  def freq(sample) do freq(sample, []) end

  # End of list -> Return Frequency List
  def freq([], freqList) do freqList end

  # List iteration -> count frequency while iterating
  # Frenquency is counted in second argument of freq/2 using numberOccurances/2
  def freq([char | rest], freqList) do freq(rest, numberOccurances(char, freqList)) end

  # Same character AGAIN -> increment character frequency
  def numberOccurances(char, [{char, n} | rest]) do [{char, n+1} | rest] end

  # Base case - Only char and Empty list -> 1 type of that character
  def numberOccurances(char, []) do [{char, 1}] end

  # New character -> Keep running algorithm
  # Iterates through freqList => O(n^2) complexity for freq & numberOccurances combined.
  def numberOccurances(char, [diffChar | rest]) do [diffChar | numberOccurances(char, rest)] end
end

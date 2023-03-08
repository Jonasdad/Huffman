defmodule Huffman do
  def sample() do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'This was an assignment in ID1019'
  end

  def test() do
    sample = sample()
    tree = tree(sample)
    coding_table = encode_table(tree)
    text = sample()
    seq = encode(text, coding_table)
    decode(seq, coding_table)
  end

  def tree(sample) do
    freqList = freq(sample)
    huffman_tree(freqList |> List.keysort(1))
  end

  # Två metoder: huffman_tree och insert
  # huffman tree bygger trädet
  # build sätter rätt löv och noder på rätt plats
  def huffman_tree([{tree, n}]) do
    tree
  end

  def huffman_tree([{char1, freq1}, {char2, freq2} | t]) do
    huffman_tree(build({{char1, char2}, freq1 + freq2}, t))
  end

  # basecase
  def build({char, freq}, []) do
    [{char, freq}]
  end

  # build the tree bottom - up. More frequent characters put higher up.
  # ádding frequencies of low frequent characters should equal node to the left.
  def build({char1, freq1}, [{char2, freq2} | t]) do
    if(freq1 < freq2) do
      [{char1, freq1}, {char2, freq2} | t]
    else
      [{char2, freq2} | build({char1, freq1}, t)]
    end
  end

  # Initiates compression
  def encode_table(tree) do
    compress(tree)
  end

  # Initiates compress/2 with an empty list to generate sequence
  def compress({left, right}) do
    compress({left, right}, [])
  end

  # Create code for each character BACKWARDS
  def compress({left, right}, sequence) do
    left_seq = compress(left, [0 | sequence])
    right_seq = compress(right, [1 | sequence])
    left_seq ++ right_seq
  end

  # Generate the proper code for each character, but re-reverse the code
  # to get the actual code.
  def compress(char, code) do
    [{char, Enum.reverse(code)}]
  end

  #
  def encode([], _) do
    []
  end
  def encode([ht | tt], etable) do
    code = elem(List.keyfind(etable, ht, 0), 1)
    List.flatten([code | encode(tt, etable)])
  end
  def decode([], _) do
    []
  end
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)

    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest}

      nil ->
        decode_char(seq, n+1, table)
    end
  end

  # Initial call of freq/1 to initiate freq/2 using only the sample text
  def freq(sample) do
    freq(sample, [])
  end

  # End of list -> Return Frequency List
  def freq([], freqList) do
    freqList
  end

  # List iteration -> count frequency while iterating
  # Frenquency is counted in second argument of freq/2 using numberOccurances/2
  def freq([char | rest], freqList) do
    freq(rest, numberOccurances(char, freqList))
  end

  # Same character AGAIN -> increment character frequency
  def numberOccurances(char, [{char, n} | rest]) do
    [{char, n + 1} | rest]
  end

  # Base case - Only char and Empty list -> 1 type of that character
  def numberOccurances(char, []) do
    [{char, 1}]
  end

  # New character -> Keep running algorithm
  # Iterates through freqList => O(n^2) complexity for freq & numberOccurances combined.
  def numberOccurances(char, [diffChar | rest]) do
    [diffChar | numberOccurances(char, rest)]
  end
end

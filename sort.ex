defmodule Sort do

  def test() do
    list = [6,132,43,1,3,53,6,90]
    sort(list)
  end
  def sort([]), do: []
  def sort([first]), do: [first]
  def sort([first | rest]), do: do_sort([first], rest)

  defp do_sort(sorted, _unsorted = [head | tail]), do: do_sort(insert(head, sorted), tail)
  defp do_sort(sorted, []), do: sorted

  # if no elements to compare against in sorted, return element as a list
  defp insert(element, _sorted = []), do: [element]
  # if element is less than the first element of the sorted list, insert at front
  defp insert(element, [min | _rest] = sorted) when element <= min, do: [element | sorted]
  # Otherwise try insert element into remainder of sorted list
  defp insert(element, [min | rest]), do: [min | insert(element, rest)]
end

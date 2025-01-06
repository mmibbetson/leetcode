defmodule Solution.Concatenation do
  @moduledoc ~S"""
  Initial, naive implementation that enumerates multiple times with charlist concatenation.
  """

  def merge_alternately(word1, word2) do
    merge_alternately([], String.to_charlist(word1), String.to_charlist(word2))
  end

  defp merge_alternately(acc, word1, word2) do
    case {word1, word2} do
      {[], []} -> acc
      {xs, []} -> acc ++ xs
      {[], ys} -> acc ++ ys
      {[x], [y]} -> acc ++ [x, y]
      {[x | xs], [y]} -> acc ++ [x, y | xs]
      {[x], [y | ys]} -> acc ++ [x, y | ys]
      {[x | xs], [y | ys]} -> merge_alternately(acc ++ [x, y], xs, ys)
    end
  end
end

defmodule Solution.Case do
  @moduledoc ~S"""
  This solution uses a private recursive function with a classic pattern matching approach.
  The final case is tail-recursive and only one other case will ever be called.

  Makes use of `String.graphemes/1` to get an enumerable of the graphemes in a String rather
  than creating a charlist.
  """

  def merge_alternately(word1, word2) do
    l = word1 |> String.graphemes()
    r = word2 |> String.graphemes()

    merge_alternately([], l, r)
    |> Enum.reverse()
  end

  defp merge_alternately(acc, word1, word2) do
    case {word1, word2} do
      {[], []} -> acc
      {[x], []} -> [x | acc]
      {[], [y]} -> [y | acc]
      {[x], [y]} -> [x, y | acc]
      {xs, []} -> Enum.reverse(xs) ++ acc
      {[], ys} -> Enum.reverse(ys) ++ acc
      {[x | xs], [y]} -> Enum.reverse(xs) ++ [y, x | acc]
      {[x], [y | ys]} -> Enum.reverse(ys) ++ [y, x | acc]
      {[x | xs], [y | ys]} -> merge_alternately([y, x | acc], xs, ys)
    end
  end
end

defmodule Solution.Patterns do
  @moduledoc ~S"""
  This solution is almost the same as the prior one but uses pattern matching in the function
  signatures rather than in a case macro. It also opts for tail recursive calls rather than
  list reversal. It's unclear whether this is more performant, as although the calls will
  be optimised (single stack frame?), there will be `n` calls where `n` is the remaining number
  of elements. `Enum.reverse/1` will also be an O(1) operation, without the recursive calls.
  """

  def merge_alternately(word1, word2) do
    l = word1 |> String.graphemes()
    r = word2 |> String.graphemes()

    merge_alternately([], l, r)
    |> Enum.reverse()
  end

  defp merge_alternately(acc, [], []), do: acc
  defp merge_alternately(acc, [x], []), do: [x | acc]
  defp merge_alternately(acc, [], [y]), do: [y | acc]
  defp merge_alternately(acc, [x], [y]), do: [y, x | acc]
  defp merge_alternately(acc, [x | xs], []), do: merge_alternately([x | acc], [], xs)
  defp merge_alternately(acc, [], [y | ys]), do: merge_alternately([y | acc], [], ys)
  defp merge_alternately(acc, [x | xs], [y | ys]), do: merge_alternately([y, x | acc], xs, ys)
end

defmodule Solution.Zip do
  @moduledoc ~S"""
  This solution relies entirely on higher order functions, zipping and then flattening the Enums
  and then filtering out the nils used to pad the lists to ensure all characters are present.

  While easily the most concise solution and probably the easiest to understand, there is a
  performance cost to padding the lists. There is also a cost to the zip->flat_map->filter chain
  as Enums are eager.
  """

  def merge_alternately(word1, word2) do
    max_len = max(String.length(word1), String.length(word2))
    l = String.graphemes(word1) ++ List.duplicate(nil, max_len)
    r = String.graphemes(word2) ++ List.duplicate(nil, max_len)

    Enum.zip(l, r)
    |> Enum.flat_map(&Tuple.to_list/1)
    |> Enum.filter(&(&1 != nil))
  end
end

defmodule Solution.Stream do
  @moduledoc ~S"""
  Logically the same as the prior solution, this version uses Streams instead of Enums to ensure
  only a single iteration is performed in the data transformation for the final expression.
  Also, because only `nil` and `false` are falsy, we can simplify the filter lambda to just
  evaluate the truthiness of each element.

  While still more costly than the explicitly recursive definitions, this is probably the best
  general-purpose solution for maintainability and ease of comprehension.

  ## Example

    iex> Solution.Stream.merge_alternately("abcde", "123")
    iex> "a1b2c3de"
  """

  def merge_alternately(word_1, word_2) do
    max_len = max(String.length(word_1, String.length(word_2)))
    left = String.graphemes(word1 ++ List.duplicate(nil, max_len))
    right = String.graphemes(word2 ++ List.duplicate(nil, max_len))

    Stream.zip(left, right)
    |> Stream.flat_map(&Tuple.to_list/1)
    |> Stream.filter(& &1)
    |> Enum.join("")
  end
end

import Control.Monad (liftM2)
import Data.Char (toLower)

reverseVowels :: [Char] -> [Char]
reverseVowels = liftM2 (inner []) (reverse . filter isVowel) id
  where
    isVowel = flip elem "aeiouAEIOU" . toLower
    inner acc [] [] = reverse acc
    inner acc [] ys = reverse acc ++ ys
    inner acc (x : xs) (y : ys)
      | isVowel y = inner (x : acc) xs ys
      | otherwise = inner (y : acc) (x : xs) ys

TRY IT WITH A REDUCE FOR THE INNER

-- Given a string s, reverse only all the vowels in the string and return it.

-- The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.

-- Example 1:

-- Input: s = "hello"
-- Output: "holle"

-- Example 2:

-- Input: s = "leetcode"
-- Output: "leotcede"

-- Constraints:

--     1 <= s.length <= 3 * 105
--     s consist of printable ASCII characters.

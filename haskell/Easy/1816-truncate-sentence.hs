-- Most readable definition
truncateSentence :: Int -> String -> String
truncateSentence n = unwords . take n . words

-- Point-free
truncateSentence' :: Int -> String -> String
truncateSentence' = unwords .: weirdDove take words

-- blackbird
(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) f g x y = f (g x y)

cardinalTwiceRemoved :: (a -> b -> c -> d) -> a -> c -> b -> d
cardinalTwiceRemoved f x g y = f x y g

goldfinch :: (a -> c -> d) -> (b -> c) -> b -> a -> d
goldfinch f g x y = f y (g x)

dove :: (a -> c -> d) -> a -> (b -> c) -> b -> d
dove f x g y = f x (g y)

-- I conceptualised this combinator out of necessity for this problem
-- It's a G combinator with the last two arguments flipped
-- Or a D combinator with the middle two arguments flipped
-- So it can be spelled as:
-- BCG
weirdDove :: (a -> c -> d) -> (b -> c) -> a -> b -> d
weirdDove = cardinalTwiceRemoved dove

-- or C**D
weirdDove' :: (a -> c -> d) -> (b -> c) -> a -> b -> d
weirdDove' = flip .: goldfinch

-- A sentence is a list of words that are separated by a single space with no leading or trailing spaces. Each of the words consists of only uppercase and lowercase English letters (no punctuation).

-- For example, "Hello World", "HELLO", and "hello world hello world" are all sentences.

-- You are given a sentence s​​​​​​ and an integer k​​​​​​. You want to truncate s​​​​​​ such that it contains only the first k​​​​​​ words. Return s​​​​​​ after truncating it.

-- Example 1:

-- Input: s = "Hello how are you Contestant", k = 4
-- Output: "Hello how are you"
-- Explanation:
-- The words in s are ["Hello", "how" "are", "you", "Contestant"].
-- The first 4 words are ["Hello", "how", "are", "you"].
-- Hence, you should return "Hello how are you".

-- Example 2:

-- Input: s = "What is the solution to this problem", k = 4
-- Output: "What is the solution"
-- Explanation:
-- The words in s are ["What", "is" "the", "solution", "to", "this", "problem"].
-- The first 4 words are ["What", "is", "the", "solution"].
-- Hence, you should return "What is the solution".

-- Example 3:

-- Input: s = "chopper is not a tanuki", k = 5
-- Output: "chopper is not a tanuki"

-- Constraints:

--     1 <= s.length <= 500
--     k is in the range [1, the number of words in s].
--     s consist of only lowercase and uppercase English letters and spaces.
--     The words in s are separated by a single space.
--     There are no leading or trailing spaces.

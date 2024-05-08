import Control.Applicative (liftA2)
import Control.Monad (liftM2)
import Data.Function (on)
import GHC.Num (integerIsNegative)

-- First solution
maximumCount :: [Int] -> Int
maximumCount = liftM2 max (length . filter (> 0)) (length . filter (< 0))

-- Custom combinator that's ALMOST the Psi combinator
-- abcde.a(b(ce)(b(de))
myCombinator :: (c -> c -> d) -> (a -> b -> c) -> a -> a -> b -> d
myCombinator f g x y z = f (g x z) (g y z)

-- Stackoverflow gigachad K. A. Buhr:
-- Spelling: ΨBΦ
psiBPhi :: (c -> c -> d) -> (a -> b -> c) -> a -> a -> b -> d
psiBPhi = on . liftA2

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) f g x y = f (g x y)

-- Second solution
maximumCount' :: [Int] -> Int
maximumCount' = psiBPhi max (length .: filter) (> 0) (< 0)

-- Adapted from code_report video comment & random reddit comment
-- I think this may actually be the best solution in terms of clarity
maximumCount'' :: [Int] -> Int
maximumCount'' = liftA2 (max `on` length) (filter (> 0)) (filter (< 0))

-- Evan's algorithm (Still need to trim down the case for ignoring zeroes... maybe just do recursive def?)
maxCount :: [Int] -> Int
maxCount xs = pos `max` neg
  where
    noZeroes = filter (/= 0) xs
    neg = length (takeWhile (< 0) noZeroes)
    pos = subtract neg (length noZeroes)

-- Given an array nums sorted in non-decreasing order, return the maximum between the number of positive integers and the number of negative integers.

--     In other words, if the number of positive integers in nums is pos and the number of negative integers is neg, then return the maximum of pos and neg.

-- Note that 0 is neither positive nor negative.

-- Example 1:

-- Input: nums = [-2,-1,-1,1,2,3]
-- Output: 3
-- Explanation: There are 3 positive integers and 3 negative integers. The maximum count among them is 3.

-- Example 2:

-- Input: nums = [-3,-2,-1,0,0,1,2]
-- Output: 3
-- Explanation: There are 2 positive integers and 3 negative integers. The maximum count among them is 3.

-- Example 3:

-- Input: nums = [5,20,66,1314]
-- Output: 4
-- Explanation: There are 4 positive integers and 0 negative integers. The maximum count among them is 4.

-- Constraints:

--     1 <= nums.length <= 2000
--     -2000 <= nums[i] <= 2000
--     nums is sorted in a non-decreasing order.

-- Follow up: Can you solve the problem in O(log(n)) time complexity?

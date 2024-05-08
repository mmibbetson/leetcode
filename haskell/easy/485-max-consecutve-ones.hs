import Data.List (group)

findMaxConsecutiveOnes :: [Int] -> Int
findMaxConsecutiveOnes xs = if null consecutiveOnes then 0 else maximum consecutiveOnes
  where
    consecutiveOnes = map length $ filter (any (/= 0)) $ group xs

-- * kind of* point-free but there is of course the xs argument to findMax

findMaxConsecutiveOnes' :: [Int] -> Int
findMaxConsecutiveOnes' = findMax . consecutiveOnes
  where
    consecutiveOnes = map length . filter (any (/= 0)) . group
    findMax xs = if null xs then 0 else maximum xs

-- Given a binary array nums, return the maximum number of consecutive 1's in the array.

-- Example 1:

-- Input: nums = [1,1,0,1,1,1]
-- Output: 3
-- Explanation: The first two digits or the last three digits are consecutive 1s. The maximum number of consecutive 1s is 3.

-- Example 2:

-- Input: nums = [1,0,1,1,0,1]
-- Output: 2

-- Constraints:

--     1 <= nums.length <= 105
--     nums[i] is either 0 or 1.

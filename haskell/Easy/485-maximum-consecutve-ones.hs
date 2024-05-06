import Data.List (group)

findMaxConsecutiveOnes :: [Int] -> Int
findMaxConsecutiveOnes xs = if null consecutiveOnes then 0 else maximum consecutiveOnes
  where
    consecutiveOnes = map length $ filter (any (/= 0)) $ group xs

-- *kind of* point-free but there is of course the xs argument to findMax
findMaxConsecutiveOnes' :: [Int] -> Int
findMaxConsecutiveOnes' = findMax . consecutiveOnes
  where
    consecutiveOnes = map length . filter (any (/= 0)) . group
    findMax xs = if null xs then 0 else maximum xs

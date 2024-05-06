import Control.Category ((>>>))
import Control.Monad (when)
import Data.List (groupBy)
import Control.Monad.List (guard)

findMaxConsecutiveOnes :: [Int] -> Int
findMaxConsecutiveOnes xs = if null consecutiveOnes then 0 else maximum consecutiveOnes
  where
    consecutiveOnes = map length $ filter (any (/= 0)) $ groupBy (==) xs

-- *kind of* point-free but there is of course the xs argument to findMax
findMaxConsecutiveOnes' :: [Int] -> Int
findMaxConsecutiveOnes' = findMax . consecutiveOnes
  where
    consecutiveOnes = map length . filter (any (/= 0)) . groupBy (==)
    findMax xs = if null xs then 0 else maximum xs

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

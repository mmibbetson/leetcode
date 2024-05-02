import Control.Applicative (liftA2)
import Control.Monad (liftM2)
import Data.Function (on)
import GHC.Arr (negRange)

-- First solution
maximumCount :: [Int] -> Int
maximumCount = liftM2 max (length . filter (> 0)) (length . filter (< 0))

-- Custom combinator that's ALMOST the Psi combinator
-- abcde.a(b(ce)(b(de))
myCombinator :: (c -> c -> d) -> (a -> b -> c) -> a -> a -> b -> d
myCombinator f g x y z = f (g x z) (g y z)

-- Stackoverflow gigachad K. A. Buhr:
-- Spelling: ΨBΦ
myCombinator' :: (c -> c -> d) -> (a -> b -> c) -> a -> a -> b -> d
myCombinator' = on . liftA2

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) f g x y = f (g x y)

-- Second solution
maximumCount' :: [Int] -> Int
maximumCount' = myCombinator max (length .: filter) (> 0) (< 0)

-- Adapted from code_report video comment
maximumCount'' :: [Int] -> Int
maximumCount'' xs = (max `on` length . flip filter xs) (> 0) (< 0)

-- Evan's algorithm (Still need to trim down the case for ignoring zeroes... maybe just do recursive def?)
maxCount :: [Int] -> Int
maxCount xs = max pos neg
  where
    noZeroes = filter (/= 0) xs
    neg = length $ takeWhile (< 0) noZeroes
    pos = length noZeroes - neg

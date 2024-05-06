import Control.Applicative (liftA2)
import Control.Monad (liftM2)
import Data.Function (on, (&))
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

-- Adapted from code_report video comment
maximumCount'' :: [Int] -> Int
maximumCount'' xs = (max `on` length . flip filter xs) (> 0) (< 0)

-- Evan's algorithm (Still need to trim down the case for ignoring zeroes... maybe just do recursive def?)
-- Chose to use reverse application and infix to see a left to right reading style
maxCount :: [Int] -> Int
maxCount xs = pos `max` neg
  where
    noZeroes = xs & filter (/= 0)
    neg = noZeroes & takeWhile (< 0) & length
    pos = noZeroes & length & subtract neg

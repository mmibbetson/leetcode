import Control.Monad (liftM2)
import Data.Function (on)

-- First solution
maximumCount :: [Int] -> Int
maximumCount = liftM2 max (length . filter (> 0)) (length . filter (< 0))

-- Custom combinator that's ALMOST the Psi combinator
-- abcde.a(b(ce)(b(de))
myCombinator :: (c -> c -> d) -> (a -> b -> c) -> a -> a -> b -> d
myCombinator f g x y z = f (g x z) (g y z)

(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) f g x y = f (g x y)

-- Second solution
maximumCount' :: [Int] -> Int
maximumCount' = myCombinator max (length .: filter) (> 0) (< 0)

-- Adapted from code_report video comment
maximumCount'' :: [Int] -> Int
maximumCount'' xs = (max `on` length . flip filter xs) (> 0) (< 0)

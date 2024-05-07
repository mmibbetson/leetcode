import Control.Applicative (liftA2)
import Data.Function (on)

findPoisonedDuration :: [Int] -> Int -> Int
findPoisonedDuration timeSeries duration =
  ((-) `on` length) timeSeries refreshes * duration + sum refreshes
  where
    diffs = drop 1 . liftA2 (zipWith (-)) id (0 :)
    refreshes = filter (< duration) (diffs timeSeries)

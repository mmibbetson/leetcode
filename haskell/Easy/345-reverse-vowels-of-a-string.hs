import Data.Char (toLower)
import Data.List (groupBy)

reverseVowels :: String -> String
reverseVowels = liftM2 rebuild segments revVowels
  where
    rebuild = concat . zipWith (\x y -> [x, y])
    revVowels = reverse . map (\x -> [x]) . filter isVowel

isVowel :: Char -> Bool
isVowel c = toLower c `elem` "aeiou"

splitByVowels :: [Char] -> [[Char]]
splitByVowels = concat . groupBy (\x y -> not (isVowel x && isVowel y))
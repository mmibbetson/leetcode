palindromeNumber :: Int -> Bool
palindromeNumber = (==) <*> (read . reverse . show)
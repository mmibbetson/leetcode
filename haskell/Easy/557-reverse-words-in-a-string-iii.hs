reverseWords :: String -> String
reverseWords = unwords . map reverse . words

main :: IO ()
main = do
    putStrLn $ show $ palindromeNumber 123212321
palindromeNumber num = show num == reverse (show num)

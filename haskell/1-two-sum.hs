twoSum :: [Int] -> Int -> [Int]
twoSum nums target = map fst $ filter (\(idx, num) -> (target - num) `elem` deleteAt idx nums) indexed
  where indexed :: [(Int, Int)] = zip [0 ..] nums

deleteAt :: Int -> [a] -> [a]
deleteAt idx xs = lft ++ rgt
  where (lft, _ : rgt) = splitAt idx xs
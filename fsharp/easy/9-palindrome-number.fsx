let isPalindrome x = let str = string x in str = (str |> List.rev |> List.map string |> String.concat "")

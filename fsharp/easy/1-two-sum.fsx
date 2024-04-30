let twoSum nums target =
    nums
    |> List.indexed
    |> List.filter (fun (idx, num) -> List.contains (target - num) (List.removeAt idx nums))
    |> List.map fst

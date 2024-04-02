let twoSum nums target =
    nums
    |> List.indexed
    |> List.filter (fun (idx, number) -> List.contains (target - number) (List.removeAt idx nums))
    |> List.map fst

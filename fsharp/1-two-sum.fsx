let twoSum nums target =
    nums
    |> Seq.indexed
    |> Seq.filter (fun (idx, num) -> Seq.contains <| target - num <| Seq.removeAt idx nums)
    |> Seq.map fst

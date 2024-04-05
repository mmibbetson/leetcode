let numJewelsInStones jewels =
    Seq.fold (fun acc cur -> if Seq.contains cur jewels then acc + 1 else acc) 0

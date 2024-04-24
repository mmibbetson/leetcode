let numJewelsInStones jewels =
    List.fold (fun acc cur -> if List.contains cur jewels then acc + 1 else acc) 0

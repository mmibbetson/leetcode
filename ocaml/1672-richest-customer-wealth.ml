module RichestCustomerWealth

// My original solution, not point-free. Still concise but less descriptive
// let maximumWealth =
//     List.fold (fun acc cur -> let w = List.sum cur in if w > acc then w else acc) 0

// Taken from Connor Hoekstra's (code_report) haskell solution
let maximumWealth = List.map List.sum >> List.max

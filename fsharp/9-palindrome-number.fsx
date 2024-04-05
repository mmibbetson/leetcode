let revString = String.concat "" << Seq.map string << Seq.rev

let isPalindrome x = let str = string x in str = revString str

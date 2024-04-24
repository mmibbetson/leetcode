let revString = String.concat "" << List.map string << List.rev

let isPalindrome x = let str = string x in str = revString str

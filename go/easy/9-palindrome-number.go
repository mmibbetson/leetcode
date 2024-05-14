func isPalindrome(x int) bool {
	if x < 0 || (x != 0 && x%10 == 0) {
		return false
	}

	if x/10 == 0 {
		return true
	}

	original := x
	reversed := 0

	for original != 0 {
		reversed = reversed*10 + original%10
		original /= 10
	}

	return x == reversed
}

// Allowing string conversion
func isPalindrome1(x int) bool {
	stringed := strconv.Itoa(x)
	reversed := reverse(stringed)

	return stringed == reversed
}

func reverse(s string) string {
	chars := []rune(s)
	for i, j := 0, len(chars)-1; i < j; i, j = i+1, j-1 {
		chars[i], chars[j] = chars[j], chars[i]
	}
	return string(chars)
}


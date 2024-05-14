func twoSum(nums []int, target int) []int {
	cache := make(map[int]int)

	for i, val := range nums {
		if j, exists := cache[target-val]; exists {
			return []int{i, j}
		}

		cache[val] = i
	}

	return []int{}
}


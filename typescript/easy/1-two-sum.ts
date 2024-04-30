function twoSum(nums: number[], target: number): number[] {
  let cache: Map<number, number> = new Map();

  for (let i = 0; i < nums.length; i++) {
      const val = nums[i];
      const complement = target - val;

      if (cache.has(complement)) {
          return [cache.get(complement)!, i]
      }

      cache.set(val, i);
  }
};

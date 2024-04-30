const romanNumerals = new Map([
  ["CM", 900],
  ["CD", 400],
  ["XC", 90],
  ["XL", 40],
  ["IX", 9],
  ["IV", 4],
  ["M", 1000],
  ["D", 500],
  ["C", 100],
  ["L", 50],
  ["X", 10],
  ["V", 5],
  ["I", 1],
]);

function romanToInt(s: string) {
  let total = 0;

  for (let numeral of romanNumerals.keys()) {
    const regex = new RegExp(numeral, "g");
    const matches = s.match(regex);
    const numberOfMatches = matches ? matches.length : 0;

    if (numeral.length === 2) s = s.replace(regex, "");

    total += numberOfMatches * romanNumerals.get(numeral)!;
  }

  return total;
}

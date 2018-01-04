function inverseCaptcha(input, step) {
  const n = input.length;
  let sum = 0;
  for (let i = 0; i < n; i++) {
    const j = (i + step) % n;
    if (input[i] == input[j]) sum += parseInt(input[i]);
  }
  return sum;
}
const day1part1 = input => inverseCaptcha(input, 1);
const day1part2 = input => inverseCaptcha(input, input.length / 2);
function stressTest(target) {
  const cells = new Map;
  const set = (x, y, value) => cells.set(x + ":" + y, value);
  const get = (x, y) => cells.has(x + ":" + y) ? cells.get(x + ":" + y) : 0;
  let n = 1;
  let position = {x: 0, y: 0};
  set(0, 0, 1);
  for (let radius = 1; true; radius++) {
    position.x++; position.y++;
    const sideLength = radius * 2;
    for (let side = 0; side < 4; side++) {
      for (let i = 0; i < sideLength; i++) {
        switch (side) {
          case 0: position.y--; break;
          case 1: position.x--; break;
          case 2: position.y++; break;
          case 3: position.x++; break;
        }
        let sum = 0;
        for (let y = -1; y <= 1; y++) {
          for (let x = -1; x <= 1; x++) {
            sum += get(position.x + x, position.y + y);
          }
        }
        if (sum > target) return {position, sum};
        set(position.x, position.y, sum);
      }
    }
  }
}
const day3part2 = input => stressTest(input).sum;
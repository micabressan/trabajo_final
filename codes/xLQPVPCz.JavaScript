var puzzlers = [
  function(a) { return 8 * a - 10; },
  function(a) { return (a - 3) * (a - 3) * (a - 3); },
  function(a) { return a * a + 4; },
  function(a) { return a % 5; }
];
var start = 2;

// build applyAndEmpty function expression here
var applyAndEmpty = function(input, queue) {
  //var res = 0;
  for (var f in queue) {
    input += f(input);
    queue.pop(f);
  }
  return input;
};

applyAndEmpty(start, puzzlers);
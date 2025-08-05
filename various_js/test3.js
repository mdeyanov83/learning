function range(arr) {
  const result = [];
  let start, end;

  if (arr[0] < arr[1]) {
    start = arr[0];
    end = arr[1];
  } else {
    start = arr[1];
    end = arr[0];
  }

  for (let i = start; i <= end; i++) {
    result.push(i);
  }
  return result;
}

function divisible(arr, num) {
  for (let elem of range(arr)) {
    if (num % elem !== 0) {
      return false;
    }
  }
  return true;
}

function smallestCommons(arr) {
  let i = 2;
  while(true) {
    if (divisible(arr, i)) return i;
    i += 2;
  }

}

console.log(smallestCommons([1,5]));

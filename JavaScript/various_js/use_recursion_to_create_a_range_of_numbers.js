function rangeOfNumbers(startNum, endNum) {
  if (startNum > endNum) {
    return [];
  } else {
    const range = rangeOfNumbers(startNum, endNum-1);
    range.push(endNum);

    return range;
  }

};

console.log(rangeOfNumbers(1, 5));

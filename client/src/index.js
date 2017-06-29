/*
/* module
**/
const print = require("./print");
print("Hello");

/*
/* es2015
**/
class Test {
  constructor(msg) {
    document.write(msg);
  }
}
let test = new Test('webpack');

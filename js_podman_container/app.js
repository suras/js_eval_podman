const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

rl.on("line", (code) => {
  try {
    const result = eval(code);
    console.log(result);
  } catch (err) {
    console.error("Error:", err.message);
  }
  rl.close();
});

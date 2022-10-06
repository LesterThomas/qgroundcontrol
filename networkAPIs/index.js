var express = require("express");
var app = express();



async function sleep(ms) {

  await new Promise(resolve => setTimeout(resolve, ms));

}



app.get("/networkCoverage", async (req, res, next) =>  {
  var queryJSON = req.query;
  console.log('Checking network coverage for GeoFence:' + JSON.stringify(queryJSON))
  await sleep(3000);
  console.log('Sending coverage OK response')
  res.json(["Network coverage OK"]);
});

app.get("/networkFeasibility", async (req, res, next) =>  {
  var queryJSON = req.query;
  await sleep(5000);
  console.log('5G Slice Service feasibility check for GeoFence:'  + JSON.stringify(queryJSON))
  await sleep(3000);
  console.log('Sending feasibility OK response')
  res.json(["Feasibility check OK"]);
});

app.get("/networkReadiness", async (req, res, next) =>  {
  var queryJSON = req.query;
  await sleep(10000);
  console.log('Ordering 5G Slice service.')
  await sleep(10000);
  console.log('Sending order success response')
  res.json(["Order success"]);
});


app.listen(3000, () => {
 console.log("Server running on port 3000");
});


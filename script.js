let price = 1.87;

let cid = [
  ['PENNY', 1.01],
  ['NICKEL', 2.05],
  ['DIME', 3.1],
  ['QUARTER', 4.25],
  ['ONE', 90],
  ['FIVE', 55],
  ['TEN', 20],
  ['TWENTY', 60],
  ['ONE HUNDRED', 100]
];

const denoms = [
  ['ONE HUNDRED', 100.00],
  ['TWENTY', 20.00],
  ['TEN', 10.00],
  ['FIVE', 5.00],
  ['ONE', 1.00],
  ['QUARTER', 0.25],
  ['DIME', 0.10],
  ['NICKEL', 0.05],
  ['PENNY', 0.01]  
]

const purchaseBtn = document.getElementById("purchase-btn");

const cashTenderedString = document.getElementById("cash");

const changeDueElement = document.getElementById("change-due");

let cashInDrawer = 0;
let changeDue = 0;

const calculateCashInDrawer = (array) => {

  for (let i = 0; i < array.length; i++) {
      cashInDrawer += array[i][1]
    }
  return cashInDrawer.toFixed(2);
}

const calculateChangeDue = (cashTendered) => {
  return parseFloat(cashTendered - price).toFixed(2)
};

const cannotTenderChange = () => {
  let firstDenomCount = 0;
  if (changeDue > 0) {
    let firstIndex = denoms.findIndex((row) => row[1] <= changeDue);
    console.log(firstIndex);
    const firstDenomString = denoms[firstIndex][0];
    console.log(firstDenomString);
    const firstDenomValue = denoms[firstIndex][1];
    for (let i = 1; firstDenomValue * i <= changeDue; i++) {
      firstDenomCount++;
    };
    console.log(firstDenomCount);
    const firstCidIndex = cid.findIndex((row) => row[0] === firstDenomString)
    const currentDenomCount = cid[firstCidIndex][1] / denoms[firstIndex][1];
    console.log(currentDenomCount);
    if (firstDenomCount <= currentDenomCount) {
      cid[firstCidIndex][1] -= firstDenomValue * firstDenomCount;
      console.log(cid);
      let remainder = (changeDue - firstDenomValue * firstDenomCount).toFixed(2);
      console.log(remainder);
      if (remainder === 0) {
        return false;
      } else {
        LOOP
      }
    } else if (firstDenomCount > currentDenomCount && currentDenomCount > 0) {
      cid[firstCidIndex][1] -= firstDenomValue * currentDenomCount;
      console.log(cid);
      let remainder = (changeDue - firstDenomValue * currentDenomCount).toFixed(2);
      console.log(remainder);
    }
  } 
};

const updateChangeDue = () => {
  if (changeDue === 0) {
    changeDueElement.innerText = "No change due - customer paid with exact cash"
  } else if (changeDue < 0) {
    alert("Customer does not have enough money to purchase the item")
  } else {
    if (calculateCashInDrawer(cid) < changeDue) {
      changeDueElement.innerText = "Status: INSUFFICIENT_FUNDS"
    } else if (calculateCashInDrawer(cid) === changeDue) {
      changeDueElement.innerText = "Status: CLOSED"
    } else if (calculateCashInDrawer(cid) > changeDue) {
      changeDueElement.innerHTML = ""; 
    }
  }
}

purchaseBtn.addEventListener("click", () => {
  const cashTendered = parseFloat(cashTenderedString.value).toFixed(2);
  changeDue = calculateChangeDue(cashTendered);
  console.log(changeDue);
  updateChangeDue();
  cannotTenderChange();
})

console.log(calculateCashInDrawer(cid));


let price = 5;

let cid = [
  ['PENNY', 1.00],
  ['NICKEL', 0],
  ['DIME', 0],
  ['QUARTER', 0],
  ['ONE', 2],
  ['FIVE', 10],
  ['TEN', 10],
  ['TWENTY', 0],
  ['ONE HUNDRED', 0]
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
let cashTendered = 0;

const calculateCashInDrawer = (array) => {
  cashInDrawer = 0;
  for (let i = 0; i < array.length; i++) {
      cashInDrawer += array[i][1]
    }
  cashInDrawer = parseFloat(cashInDrawer.toFixed(2))
}

const calculateChangeDue = (cashTendered) => {
  return parseFloat((cashTendered - price).toFixed(2))
};

const tenderChange = (changeNeeded) => {
  let denomCountLimit = 0;
  console.log(cashInDrawer);
  if (changeNeeded > 0 && cashInDrawer > changeNeeded) {
    const denomIndex = denoms.findIndex((row) => row[1] <= changeNeeded);
    console.log(denomIndex);
    const denomString = denoms[denomIndex][0];
    console.log(denomString);
    const denomValue = denoms[denomIndex][1];
    for (let i = 1; denomValue * i <= changeNeeded; i++) {
      denomCountLimit++;
    };
    console.log(denomCountLimit);
    const cidIndex = cid.findIndex((row) => row[0] === denomString)
    const currentDenomCount = cid[cidIndex][1] / denoms[denomIndex][1];
    console.log(currentDenomCount);
    if (denomCountLimit <= currentDenomCount) {
      cid[cidIndex][1] -= denomValue * denomCountLimit;
      console.log(cid);
      if (changeDueElement.innerHTML === "Change due:") {
        changeDueElement.innerHTML =
          `Status: OPEN<div>${denomString}: $${(denomValue * denomCountLimit).toFixed(2)}</div>`;
      } else {
        changeDueElement.innerHTML +=
          `<div>${denomString}: $${(denomValue * denomCountLimit).toFixed(2)}</div>`;
      }
      let remainder = parseFloat((changeNeeded - denomValue * denomCountLimit).toFixed(2));
      console.log(remainder);
      if (remainder === 0) {
        return;
      } else {
        tenderChange(remainder)
      }
    } else if (denomCountLimit > currentDenomCount && currentDenomCount > 0 && denomIndex !== denoms.length - 1) {
        cid[cidIndex][1] -= denomValue * currentDenomCount;
        console.log(cid);
        if (changeDueElement.innerHTML === "Change due:") {
          changeDueElement.innerHTML =
            `Status: OPEN<div>${denomString}: $${(denomValue * currentDenomCount).toFixed(2)}</div>`;
        } else {
          changeDueElement.innerHTML +=
            `<div>${denomString}: $${(denomValue * currentDenomCount).toFixed(2)}</div>`;
        }
        let remainder = parseFloat((changeNeeded - denomValue * currentDenomCount).toFixed(2));
        console.log(remainder);
        if (remainder === 0) {
          return;
        } else {
        tenderChange(remainder)
      }
    } else if (currentDenomCount === 0 && denomIndex !== denoms.length - 1) {
        denoms.splice(denomIndex, 1);
        tenderChange(changeNeeded)
    } else if (denomIndex === denoms.length - 1 && currentDenomCount < denomCountLimit) {
        changeDueElement.innerHTML = "Status: INSUFFICIENT_FUNDS"
    }
  } else if (price > cashTendered) {
      alert("Customer does not have enough money to purchase the item")
  } else if (changeNeeded === 0) {
      changeDueElement.innerText = "No change due - customer paid with exact cash"
  } else if (changeNeeded === cashInDrawer) {
      changeDueElement.innerHTML = "Status: CLOSED";
      for (let i = denoms.length - 1; i > - 1; i--) {
      if (cid[i][1] !== 0) {
        changeDueElement.innerHTML += `<div>${cid[i][0]}: $${cid[i][1].toFixed(2)}</div>`
        }
    }
  } else if (changeNeeded > cashInDrawer) {
      changeDueElement.innerText = "Status: INSUFFICIENT_FUNDS";
  }
}

purchaseBtn.addEventListener("click", () => {
  changeDueElement.innerHTML = "Change due:";
  cashTendered = parseFloat((cashTenderedString.value));
  changeDue = calculateChangeDue(cashTendered);
  console.log(changeDue);
  calculateCashInDrawer(cid);
  console.log(cashInDrawer);
  tenderChange(changeDue);
})

console.log(calculateCashInDrawer(cid));


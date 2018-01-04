//--------------------------------------------------------------------------------------------------------------------------
//---------------------------InvestmentBroker.script------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

// Clear database
write("_Investment_DB.txt","","w");

// Clean ports
for (portId = 1; portId <= 10; portId++)
{
    inputCommand = ""
    while (inputCommand !== 'NULL PORT DATA')
    {
        print(inputCommand);
        inputCommand = read(portId);
    }
}

run("_InvestmentBroker.script", 1);

//--------------------------------------------------------------------------------------------------------------------------
//---------------------------_InvestmentBroker.script-----------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

// kill any scripts from previous run
localHost = getHostname();
scriptKill("_InvestmentBroker_Data.script", localHost);
scriptKill("_InvestmentBroker_Manager.script", localHost);

COMMISION_FEE = 100000;

INPUT_PORT = 10;

// Stock ID (add entries here to handle more stocks)
function GetStockParamId(stockSymbol)
{
    if (stockSymbol === "APHE") return 0;
    if (stockSymbol === "CTYS") return 1;
    if (stockSymbol === "JGN") return 2;
    if (stockSymbol === "SGC") return 3;
    return -1;
}

// Stock paramaters, according to id returned by GetStockParamId
// Moving Average size, History buffer size, buy/sell threshold (0.01 - 1%)
STOCK_PARAMS = [];
STOCK_PARAMS[0] = [9, 5, 0.01];
STOCK_PARAMS[1] = [5, 10, 0.01];
STOCK_PARAMS[2] = [7, 7, 0.01];
STOCK_PARAMS[3] = [5, 6, 0.01];

// Port assignment per stock
StockPort = [-1, -1, -1, -1];

freePort = 1;

// Managed stock data, each managed stock will have an entry here (with the stock port as index) containing an array with the following data:
// 0 : StockSymbol
// 1 : available cash
// 2 : starting cash
// 3 : starting price
// 4 : total worth
ManagerData = [];

function SaveManagerDataInDB()
{
	// Write current managed stock data to file, will be used to restart the script after a reload
    write("_Investment_DB.txt","","w");
    for (i = 1; i < freePort; i++)
    {
        if (ManagerData[i][0] !== "")
        {
            write("_Investment_DB.txt", i + "," + ManagerData[i][0] + "," + ManagerData[i][1] + "," + ManagerData[i][2] + "," + ManagerData[i][3] + "," + ManagerData[i][4] + "|");
        }
    }   
}

previousData = read("_Investment_DB.txt");
if (previousData !== "")
{
    // load previous run data
    previousData = previousData.split("|");
    for (i = 0; i < previousData.length - 1; i++)
    {
        data = previousData[i].split(",");
        stockId = 1 * data[0];
        ManagerData[stockId] = [];
        ManagerData[stockId][0] = data[1];
        ManagerData[stockId][1] = 1 * data[2];
        ManagerData[stockId][2] = 1 * data[3];
        ManagerData[stockId][3] = 1 * data[4];
        ManagerData[stockId][4] = 1 * data[5];
        if (stockId >= freePort)
        {
            freePort = stockId + 1;
        }
        StockPort[GetStockParamId(data[1])] = stockId;
    }
    
    // re-run previous managers with new cash argument
    for (i = 1; i < freePort; i++)
    {
        stockSymbol = ManagerData[i][0];
        stockParamId = GetStockParamId(stockSymbol);
        run("_InvestmentBroker_Data.script", 1, stockSymbol, i, STOCK_PARAMS[stockParamId][0]);
        run("_InvestmentBroker_Manager.script", 1, stockSymbol, i, STOCK_PARAMS[stockParamId][1], STOCK_PARAMS[stockParamId][2], ManagerData[stockId][1]);
    }
}

doLoop = true;

while (doLoop)
{
    inputCommand = read(INPUT_PORT);
    if (inputCommand !== 'NULL PORT DATA')
    {
        inputCommand = inputCommand.split(" ");
        if (inputCommand[0] == "A" && freePort < INPUT_PORT)
        {
			// Add a new managed stock
            stockSymbol = inputCommand[1];
            stockParamId = GetStockParamId(stockSymbol);
            run("_InvestmentBroker_Data.script", 1, inputCommand[1], freePort, STOCK_PARAMS[stockParamId][0]);
            run("_InvestmentBroker_Manager.script", 1, inputCommand[1], freePort, STOCK_PARAMS[stockParamId][1], STOCK_PARAMS[stockParamId][2], 1 * inputCommand[2]);
            print("Adding managed stock " + inputCommand[1] + ", cash: " + inputCommand[2] + "$");
            stockPrice = getStockPrice(stockSymbol);
            cash = 1 * inputCommand[2];
            ManagerData[freePort] = [];
            ManagerData[freePort][0] = stockSymbol;
            ManagerData[freePort][1] = cash;
            ManagerData[freePort][2] = cash;
            ManagerData[freePort][3] = stockPrice;
            ManagerData[freePort][4] = cash;
            SaveManagerDataInDB();
            StockPort[stockParamId] = freePort;
            freePort++;
        }

        if (inputCommand[0] == "L")
        {
			// Liquidate stock
            stockSymbol = inputCommand[1];
            stockParamId = GetStockParamId(stockSymbol);
            stockId = StockPort[stockParamId];
            if (stockId != -1)
            {
				// Kill Data gathering script
                kill("_InvestmentBroker_Data.script", localHost, stockSymbol, stockId, STOCK_PARAMS[stockParamId][0]);
				// Send liquidation command to manage script (it is not killed immediatly to ensure any queued stock transactions will be handled before selling a stock to avoid selling with the wrong price)
                write(stockId, "_L");
            }
        }

        if (inputCommand[0] == "__L")
        {
			// Liquidation response from manage script, script has terminated and any outstanding transactions has been processed
            stockId = 1 * inputCommand[1];
            stockSymbol = ManagerData[stockId][0];
            stockPrice = getStockPrice(stockSymbol);
            stockData = getStockPosition(stockSymbol);
            profit = stockData[0] * (stockPrice - stockData[1]);
            if (profit > COMMISION_FEE * 2)
            {
                sellStock(stockSymbol, stockData[0]);
                print("Sold " + stockSymbol + " shares for " + profit.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$");
                ManagerData[stockId][4] = ManagerData[stockId][4] + profit;

            }
            else
            {
                sellPrice = stockData[1] + (COMMISION_FEE * 2 / stockData[0]);
                placeOrder(stockSymbol, stockData[0], sellPrice, "limitsell", "long");
                tprint("placed limit sell order on " + stockSymbol + " for " + stockData[0] + " shares at " + sellPrice.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$");
            }
            holdProfit = ((ManagerData[stockId][2] - COMMISION_FEE) / ManagerData[stockId][3]) * (stockPrice - ManagerData[stockId][3]);
            profit = ManagerData[stockId][4] - ManagerData[stockId][2];
            tprint("Final profit for " + stockSymbol + ": " + profit.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$ (" +
                    holdProfit.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$)");
			
			// End managment for stock
            ManagerData[stockId][0] = "";
            SaveManagerDataInDB();
        }

        if (inputCommand[0] == "_Sb")
        {
			// Process stock purchase transaction
            stockId = 1 * inputCommand[1];
            cost = 1 * inputCommand[2];
            print("Bought " + ManagerData[stockId][0] + " shares for " + cost.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$");
			
			// Update available cash reserve
            ManagerData[stockId][1] = ManagerData[stockId][1] - cost;
            SaveManagerDataInDB();
        }
        
        if (inputCommand[0] == "_Ss")
        {
			// Process stock sale transaction
            stockId = 1 * inputCommand[1];
            income = 1 * inputCommand[2];
            print("Sold " + ManagerData[stockId][0] + " shares for " + income.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$");
			
			// Update available cash reserve and total worth
            ManagerData[stockId][1] = ManagerData[stockId][1] + income;
            ManagerData[stockId][4] = ManagerData[stockId][1];
            SaveManagerDataInDB();
        }
        
        if (inputCommand[0] == "S")
        {
			// Print stock status
            totalProfit = 0;
            totalHoldProfit = 0;
            for (i = 1; i < freePort; i++)
            {
                if (ManagerData[i][0] !== "")
                {
                    profit = ManagerData[i][4] - ManagerData[i][2];
                    totalProfit += profit;
                    stockData = getStockPosition(ManagerData[i][0]);
                    stockPrice = getStockPrice(ManagerData[i][0]);
                    holdProfit = ((ManagerData[i][2] - COMMISION_FEE) / ManagerData[i][3]) * (stockPrice - ManagerData[i][3]);
                    totalHoldProfit += holdProfit;
                    tprint(ManagerData[i][0] + ": " + stockData[0] + " Shares, Profit: " + profit.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$ (" +
                            holdProfit.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$)");
                }
            }
            tprint("Total profit: " + totalProfit.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$ (" +
                        totalHoldProfit.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,') + "$)");
        }
    }  
}

//--------------------------------------------------------------------------------------------------------------------------
//---------------------------_InvestmentBroker_Data.script------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

StockSymbol = args[0];
DATA_PORT = args[1];
MovingAverageSize = args[1];

prices = [];
sum = 0;
lastPrice = -1;

while(true)
{
    price = getStockPrice(StockSymbol);
    if (price != lastPrice)
    {
        prices.push(price);
        sum += price;
        if (prices.length > MovingAverageSize)
        {
            sum -= prices.shift();
            avg = sum/MovingAverageSize;
            write(DATA_PORT, avg);
        }
        lastPrice = price;
    }
}

//--------------------------------------------------------------------------------------------------------------------------
//---------------------------_InvestmentBroker_Manager.script---------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

COMMISION_FEE = 100000;
INPUT_PORT = 10;

localHost = getHostname();

StockSymbol = args[0];
DATA_PORT = args[1];
HistorySize = args[2];

BuyThreshold = 1 + args[3];
SellThreshold = 1 - args[3];

cash = args[4];

movingAverageHistory = [];

doLoop = true;

while (doLoop)
{
    movingAverage = read(DATA_PORT);
    if (movingAverage === "_L")
    {
		// Liquidate command given, terminate script
        doLoop = false;
        write(INPUT_PORT, "__L " + DATA_PORT);
    }
    else if (movingAverage !== 'NULL PORT DATA')
    {
        movingAverageHistory.push(movingAverage);
        if (movingAverageHistory.length > HistorySize)
        {
            previousMovingAverage = movingAverageHistory.shift();
            if (movingAverage > (previousMovingAverage * BuyThreshold))
            {
				// MA is trending up, buy stocks if cash is available
                additionalCost = 0;
                prevStockData = getStockPosition(StockSymbol);
                stockPrice = getStockPrice(StockSymbol);
                if (cash > stockPrice + COMMISION_FEE)
                {
					// Calculate amount of stocks to purchase
                    newShares = Math.floor((cash - additionalCost - COMMISION_FEE) / stockPrice);
                    while (!buyStock(StockSymbol, newShares) && newShares > 0)
                    {
						// We failed to buy stocks, adjust cash and retry
                        availableCash = getServerMoneyAvailable("home");
                        if (availableCash < cash)
                        {
							// Less cash is available then should be (can happen due to purchase/sell orders happening at a different price then we measured or simply because the user spent the money on something)
							// Adjust cost to account for discrepency (I'm adjusting the cose instead of the available cash to reflect the missing cash in the broker script)
                            additionalCost += (cash - availableCash);
                        }
						// Recalculate amount of stocks to purchase
                        newShares = Math.floor((cash - additionalCost - COMMISION_FEE) / getStockPrice(StockSymbol));
                    }
                    if (newShares > 0)
                    {
                        stockData = getStockPosition(StockSymbol);
                        if (prevStockData[0] === 0)
                        {
                            cost = (COMMISION_FEE + (newShares * stockData[1]));
                        }
                        else
                        {
                            cost = COMMISION_FEE + ((stockData[1] * stockData[0]) - (prevStockData[1] * prevStockData[0]));
                        }
                        cost += additionalCost;
                        cash -= cost;
						// Send transaction data to broker
                        write(INPUT_PORT, "_Sb " + DATA_PORT + " " + cost);
                    }
                }
            }
            if (movingAverage < (previousMovingAverage * SellThreshold))
            {
				// MA is trending down, sell stocks if it's profitable
                stockData = getStockPosition(StockSymbol);
                stockPrice = getStockPrice(StockSymbol);
                profit = stockData[0] * (stockPrice - stockData[1]);
                if (profit > COMMISION_FEE * 2)
                {
                    sellStock(StockSymbol, stockData[0]);
                    stockPrice = getStockPrice(StockSymbol);
                    income = (stockData[0] * stockPrice) - COMMISION_FEE; 
                    cash += income;
					// Send transaction data to broker
                    write(INPUT_PORT, "_Ss " + DATA_PORT + " " + income);
                }
            }
        }
    }
}

//--------------------------------------------------------------------------------------------------------------------------
//---------------------------_InvestmentBroker_Msg.script-------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

INPUT_PORT = 10;
msg = "";
for (i = 0; i < args.length; i++)
{
    msg = msg + args[i] + " ";
}
write(INPUT_PORT, msg);
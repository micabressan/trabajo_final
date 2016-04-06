#property strict

extern int OrderOpenHour = 11;      
extern int OrderOpenMinute = 00;
extern int OrderCloseHour = 23;     
extern int OrderCloseMinute = 59;   
extern int Slippage = 3;
extern int MagicNumber = 12345;
extern double MaxRisk = 0.03; 
extern int MaxOrders = 2; 

double PipValue = 10.0;
int MarketMinStop = MarketInfo(Symbol(), MODE_STOPLEVEL);

int BuyStopOrder, SellStopOrder;

double MarketDivisor[] = {1.0, 0.1, 0.01, 0.001, 0.0001, 0.00001};
int MarketPrecision = MarketInfo(Symbol(), MODE_DIGITS);

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   //---   
        
   //---
   
   return(INIT_SUCCEEDED);
}

int start()
{
   //---
      
      double MyPoint = Point;
      
      if(Digits==3 || Digits==5){ MyPoint=Point*10; }
   
      if(Hour() == OrderOpenHour && Minute() == OrderOpenMinute)
      {
        
         // Draw vline at current time and two hours back to make visualization of trade easier
         
         DrawVline(Time[2]);
         DrawVline(Time[0]);     
         
         // Get Entry prices
   
         double LongEntryPrice = High[1];
         double ShortEntryPrice = Low[1];
         
         // Check OrdersTotal()
         
         if(OrdersTotal() < MaxOrders)
         {
            // Risk Calculation
         
            double PositionSize = CalculatePositionSize(LongEntryPrice, ShortEntryPrice);
         
               // Place Pending Orders
            
               double EntryPriceBuy = (LongEntryPrice+(MarketMinStop*Point));
               double StopLossBuy = (ShortEntryPrice-(MarketMinStop*Point));     
                           
               BuyStopOrder = OrderSend(Symbol(), OP_BUYSTOP, PositionSize, EntryPriceBuy, Slippage, StopLossBuy, 0, "Long Pending Order", clrGreen);
            
               double EntryPriceSell = (ShortEntryPrice-(MarketMinStop*Point));
               double StopLossSell = (LongEntryPrice+(MarketMinStop*Point));
               
               SellStopOrder = OrderSend(Symbol(), OP_SELLSTOP, PositionSize, EntryPriceSell, Slippage, StopLossSell, 0, "Short Pending Order", clrRed);          
            
               Print("StopLoss for SellStop Order @ Bid: ", Bid, " | ", StopLossSell);
            
                  // Check if OrderType (OP_BUYSTOP -> OP_BUY) changed.
                  
                  if(BuyStopOrder > 0)
                  {
                     if(OrderSelect(BuyStopOrder, SELECT_BY_TICKET))
                     {
                        if(OrderType() == OP_BUY)
                        {
                           SetTakeProfit(OrderTicket(), OrderOpenPrice(), OrderStopLoss());
                           
                           // Delete Pending Sell Stop Order
                           Print("Ordertype OP_BUYSTOP changed to OP_BUY. - Deleting pending SELLSTOP order.");
                           DeleteOrder(SellStopOrder);                    
                        }
                     }
                     else
                     {
                        Print("Failed to select BuyStopOrder #", BuyStopOrder," | ", GetLastError());
                     }
                  }
            
                  // Check if OrderType (OP_SELLSTOP -> OP_SELL) changed.
                  
                  if(SellStopOrder > 0)
                  {
                     if(OrderSelect(SellStopOrder, SELECT_BY_TICKET))
                     {
                        if(OrderType() == OP_SELL)
                        {
                           SetTakeProfit(OrderTicket(), OrderOpenPrice(), OrderStopLoss());
                           
                           // Delete Pending Buy Stop Order
                           Print("Ordertype OP_SELLSTOP changed to OP_SELL. - Deleting pending BUYSTOP order.");
                           DeleteOrder(BuyStopOrder);                      
                        }
                     }
                     else
                     {
                        Print("Failed to select SellStopOrder #", SellStopOrder," | ", GetLastError());
                     }
                  }   
        }        
      }        
      
      
      // Close any open positions @ 23:59 Brokertime to avoid swap costs
      
      if(Hour() == OrderCloseHour && Minute() == OrderCloseMinute)
      {
         
         if(OrdersTotal() > 0)
         {
            if(BuyStopOrder > 0)
            {
               if(OrderSelect(BuyStopOrder, SELECT_BY_TICKET)){
                  
                  if(OrderType() == OP_BUY)
                  {
                     if(OrderClose(OrderTicket(), OrderLots(), Ask, Slippage, clrNONE))
                     {
                       BuyStopOrder = 0;
                     }
                  }
                  
                  if(OrderType() == OP_BUYSTOP)
                  {
                     if(OrderDelete(OrderTicket(), clrNONE))
                     {
                       BuyStopOrder = 0;
                     }
                  }
               }
            }
            
            if(SellStopOrder > 0)
            {
               if(OrderSelect(SellStopOrder, SELECT_BY_TICKET)){
               
                  if(OrderType() == OP_SELL)
                  {
                     if(OrderClose(OrderTicket(), OrderLots(), Bid, Slippage, clrNONE))
                     {
                        SellStopOrder = 0;
                     }
                  }
                  
                  if(OrderType() == OP_SELLSTOP)
                  {
                     if(OrderDelete(OrderTicket(), clrNONE))
                     {
                       SellStopOrder = 0;
                     }
                  }
               
               }
            } 
         }
      }
   
   //---
   
   ResetTicket(BuyStopOrder);
   ResetTicket(SellStopOrder);
   
   return(0);
}

void DrawVline(datetime DrawTime)
{
   //---
     
     string LineName = "Vertical Line " + DoubleToStr(DrawTime, 0);
     
     if(!ObjectCreate(LineName, OBJ_VLINE, 0, DrawTime, 0))
     {
         Print("Failed to create Vertical Line. Error Code: ", GetLastError());
     }
     
     ObjectSet(LineName, OBJPROP_COLOR, Gray);
     
   //---
}

string PriceToStr(double p){ return( DoubleToStr(p, Digits) ); }

double CalculatePositionSize(double LongEntryPrice, double ShortEntryPrice)
{
   //---
           
      double StopLossPrice = LongEntryPrice - ShortEntryPrice;
      double StopLossPoints = MathAbs(StopLossPrice / MarketDivisor[MarketPrecision]);
      
      double Lots = NormalizeDouble((AccountFreeMargin() * MaxRisk) / (StopLossPoints * PipValue), 1);
   
   //---
   
   return(Lots);
   
   //--- 
}

void SetTakeProfit(int ticket, double LongEntryPrice, double ShortEntryPrice)
{
   //--
   
      if(OrderSelect(ticket, SELECT_BY_TICKET))
      {
         
         if(OrderCloseTime() == 0 && OrderTakeProfit() == 0)
         {
            double TakeProfitPrice = LongEntryPrice - ShortEntryPrice;
            
            double TakeProfit = 0;
            
            if(OrderType() == OP_BUY)
            {
               TakeProfit = OrderOpenPrice() + TakeProfitPrice;
            }
            
            if(OrderType() == OP_SELL)
            {
               TakeProfit = OrderOpenPrice() - TakeProfitPrice;
            }
            
            if(!OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), TakeProfit, 0, Orange))
            {
               Print("Failed to set TP for Ordertype: ", OrderType(), "to ", TakeProfit, " Error: ", GetLastError());
            }
            
         } 
      }
   
   //--
}

void DeleteOrder(int ticket)
{
   //--
      
      if(OrderDelete(ticket, clrNONE))
      {
         ticket = 0; 
      }
      else
      {
         Print("Failed to delete Ticket for Ordertype: ", OrderType(), ". Error: ", GetLastError());
      }
   
   //---  
}

void ResetTicket(int ticket)
{
   //--
      
      if(OrderSelect(ticket, SELECT_BY_TICKET))
      {
         if(OrderCloseTime() > 0)
         {
            ticket = 0;
         }
      }

   //--
}
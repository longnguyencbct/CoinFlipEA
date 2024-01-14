//+------------------------------------------------------------------+
//|                                                   CoinFlipEA.mq5 |
//|           clongnguynvn@gmail.com or long.nguyencbct@hcmut.edu.vn |
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
#include "InpConfig.mqh"
#include "GlobalVar.mqh"
#include "Helper.mqh"
#include "CondTrigger.mqh"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   if(!CheckInputs()){return INIT_PARAMETERS_INCORRECT;}
   trade.SetExpertMagicNumber(InpMagicnumber);
   if(!InpFixedRandom){
      srand(GetTickCount());
   }else{
      srand(1336);
   }
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   

}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // generate random signal
   if(!InpFixedRandom){
      int temp=random_number;
      while(random_number==temp&&random_number%2==temp%2){
         random_number = rand();
      }
      if(random_number%2==1){
         random_signal=true;
      }else{
         random_signal=false;
      }
   }
   if(!IsNewBar()){return;}
   
   //Get current tick
   if(!SymbolInfoTick(_Symbol,currentTick)){Print("Failed to get tick"); return;}
   
   //count open positions
   if(!CountOpenPositions(cntBuy,cntSell)){return;}
   
   if(InpFixedRandom){
      random_number = rand();
      if(random_number%2==1){
         random_signal=true;
      }else{
         random_signal=false;
      }
   }
   
   //check for lower band cross to open a buy position
   if(Trigger(true)){
      double sl = currentTick.bid-(InpStopLoss)*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      double tp = InpTakeProfit==0?0:currentTick.bid+(InpTakeProfit)*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      
      if(!NormalizePrice(sl,sl)){return;}
      if(!NormalizePrice(tp,tp)){return;}
      
      //calculate lots
      double lots;
      if(!CalculateLots(currentTick.bid-sl,lots)){return;}
      
      trade.PositionOpen(_Symbol,ORDER_TYPE_BUY,InpVolume,currentTick.ask,sl,tp,"Coin Flip EA");  
   }
   //check for upper band cross to open a sell position
   if(Trigger(false)){
      double sl = currentTick.ask+InpStopLoss*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      double tp = InpTakeProfit==0?0:currentTick.ask-InpTakeProfit*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      
      //calculate lots
      double lots;
      if(!CalculateLots(sl-currentTick.ask,lots)){return;}
      
      if(!NormalizePrice(sl,sl)){return;}
      if(!NormalizePrice(tp,tp)){return;}
      
      
      trade.PositionOpen(_Symbol,ORDER_TYPE_SELL,InpVolume,currentTick.bid,sl,tp,"Coin Flip EA");  
   }
}
//+------------------------------------------------------------------+

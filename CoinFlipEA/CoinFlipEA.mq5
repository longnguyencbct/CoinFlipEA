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
#include "CondFilter.mqh"
#include "CondClose.mqh"
#include "TrendObservation.mqh"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   if(!CheckInputs()){return INIT_PARAMETERS_INCORRECT;}
   trade.SetExpertMagicNumber(InpMagicnumber);
   if(InpAROONPeriod!=0){
      AROON_handle=iCustom(_Symbol,InpAROONTimeframe,"Custom\\aroon",InpAROONPeriod,InpAROONShift);
      
      if(AROON_handle==INVALID_HANDLE){
         Alert("Failed to create AROON indicatior handle");
         return INIT_FAILED;
      }
      
      ArraySetAsSeries(AROON_Up,true);
      ArraySetAsSeries(AROON_Down,true);
   }
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
   if(InpAROONPeriod!=0){
      //release AROON indicator handle
      if(AROON_handle!=INVALID_HANDLE){IndicatorRelease(AROON_handle);}
   }

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
   
   if(InpAROONPeriod!=0){
      //Get AROON Indicator values
      int values=CopyBuffer(AROON_handle,0,0,1,AROON_Up)
                +CopyBuffer(AROON_handle,1,0,1,AROON_Down);
                
      if(values!=2){
         Print("Failed to get AROON  indicator values, value:",values);
         Print(GetLastError());
         return;
      }
      string curr_state_str;
      switch(curr_state){
         case UP_TREND:
            curr_state_str="Up Trend";
            break;
         case DOWN_TREND:
            curr_state_str="Down Trend";
            break;
         case NOT_TRENDING:
            curr_state_str="Not Trending";
            break;
      }
      Comment("AROON:",
              "\n Up[0]: ",AROON_Up[0],
              "\n Down[0]: ",AROON_Down[0],
              "\n Market State: ",curr_state_str);
   }
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
   
   // Trend Observation
   TrendObservation();
   
   //Close condition
   CondClose();
   
   //check for lower band cross to open a buy position
   if(Trigger(true)&&Filter(true)){
      double sl = currentTick.bid-(InpStopLoss)*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      double tp = InpTakeProfit==0?0:currentTick.bid+(InpTakeProfit)*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      
      if(!NormalizePrice(sl,sl)){return;}
      if(!NormalizePrice(tp,tp)){return;}
      
      //calculate lots
      double lots;
      if(!CalculateLots(currentTick.bid-sl,lots)){return;}
      
      trade.PositionOpen(_Symbol,ORDER_TYPE_BUY,lots,currentTick.ask,sl,tp,"Coin Flip EA");  
   }
   //check for upper band cross to open a sell position
   if(Trigger(false)&&Filter(false)){
      double sl = currentTick.ask+InpStopLoss*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      double tp = InpTakeProfit==0?0:currentTick.ask-InpTakeProfit*SymbolInfoDouble(_Symbol,SYMBOL_POINT);
      
      //calculate lots
      double lots;
      if(!CalculateLots(currentTick.bid-sl,lots)){return;}
      
      if(!NormalizePrice(sl,sl)){return;}
      if(!NormalizePrice(tp,tp)){return;}
      
      
      trade.PositionOpen(_Symbol,ORDER_TYPE_SELL,lots,currentTick.bid,sl,tp,"Coin Flip EA");  
   }
}
//+------------------------------------------------------------------+

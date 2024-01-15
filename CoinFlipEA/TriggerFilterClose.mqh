#include "GlobalVar.mqh"
#include "Helper.mqh"

//+------------------------------------------------------------------+
//| Trigger function                                                 |
//+------------------------------------------------------------------+

bool Trigger(bool buy_sell){
   if(buy_sell){// buy
      return   cntBuy<1&&random_signal;
   }else{// sell
      return   cntSell<1&&!random_signal;
   }
}

//+------------------------------------------------------------------+
//| Filter function                                                  |
//+------------------------------------------------------------------+

bool Filter(bool buy_sell){
   if(buy_sell){// buy
      return InpAROONPeriod!=0?curr_state==UP_TREND:true;
   }else{// sell
      return InpAROONPeriod!=0?curr_state==DOWN_TREND:true;
   }
}

//+------------------------------------------------------------------+
//| Close function                                                   |
//+------------------------------------------------------------------+
void CondClose(){
   if(new_state){
      if(InpCloseCond!=NO_CLOSING){
         ClosePositions(0);
      }
      new_state=false;
   }
}
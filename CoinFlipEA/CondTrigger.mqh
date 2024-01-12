#include "GlobalVar.mqh"
//+------------------------------------------------------------------+
//| Trigger functions                                                |
//+------------------------------------------------------------------+

bool Trigger(bool buy_sell){
   if(buy_sell){// buy
      return   cntBuy<1&&random_signal;
   }else{// sell
      return   cntSell<1&&!random_signal;
   }
}
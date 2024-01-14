#include "GlobalVar.mqh"
#include "InpConfig.mqh"
//+------------------------------------------------------------------+
//| Filter functions                                                 |
//+------------------------------------------------------------------+

bool Filter(bool buy_sell){
   if(buy_sell){// buy
      return InpAROONPeriod!=0?curr_state==UP_TREND:true;
   }else{// sell
      return InpAROONPeriod!=0?curr_state==DOWN_TREND:true;
   }
}

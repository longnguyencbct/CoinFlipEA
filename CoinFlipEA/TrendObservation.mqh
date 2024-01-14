//+------------------------------------------------------------------+
//| Trend Observation                                                |
//+------------------------------------------------------------------+
#include "GlobalVar.mqh"
#include "InpConfig.mqh"

void TrendObservation(){
   if(InpAROONPeriod!=0){
      if(AROON_Up[0]>=InpAROONFilterLevel&&AROON_Down[0]<InpAROONFilterLevel){
         if(curr_state!=UP_TREND){new_state=true;}
         curr_state=UP_TREND;
         return;
      }
      else if(AROON_Up[0]<InpAROONFilterLevel&&AROON_Down[0]>=InpAROONFilterLevel){
         if(curr_state!=DOWN_TREND){new_state=true;}
         curr_state=DOWN_TREND;
         return;
      }else{
         if(curr_state!=NOT_TRENDING){new_state=true;}
         curr_state=NOT_TRENDING;
         return;
      }
   }
}


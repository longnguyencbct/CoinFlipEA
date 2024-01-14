//+------------------------------------------------------------------+
//| Close functions                                                  |
//+------------------------------------------------------------------+
#include "GlobalVar.mqh"
#include "Helper.mqh"
void CondClose(){
   if(new_state){
      if(InpAROONCloseAtNewState){
         ClosePositions(0);
      }
      new_state=false;
   }
}
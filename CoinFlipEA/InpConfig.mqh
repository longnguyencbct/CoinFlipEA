//+------------------------------------------------------------------+
//| Input Configuration                                              |
//+------------------------------------------------------------------+
input group "==== General ====";
static input long InpMagicnumber= 234567822;         //magic number
input double InpVolume = 0.01;                  //lots
input int InpStopLoss = 100;                    //stop loss
input int InpTakeProfit = 100;                  //take profit
input ENUM_TIMEFRAMES InpTimeframe = PERIOD_H1; //Timeframe
input group "==== Coin Flip Config ====";
input int InpExeTimes = 1;                      //number of executions
input bool InpFixedRandom = false;              //fixed random?

bool CheckInputs(){
   if(InpMagicnumber<=0){
      Alert("Wrong input: Magicnumber <= 0");
      return(false);
   }
   if(InpVolume<=0){
      Alert("Wrong input: Lots size <= 0");
      return(false);
   }
   if(InpStopLoss<0){
      Alert("Wrong input: Stop loss < 0");
      return(false);
   }
   if(InpTakeProfit<0){
      Alert("Wrong input: Take profit < 0");
      return(false);
   }
   if(InpExeTimes<0){
      Alert("Wrong input: number of executions < 0");
      return(false);
   }
   return true;
}
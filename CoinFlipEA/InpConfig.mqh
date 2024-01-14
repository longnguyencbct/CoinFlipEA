//+------------------------------------------------------------------+
//| Input Configuration                                              |
//+------------------------------------------------------------------+
enum LOT_MODE_ENUM{
   LOT_MODE_FIXED,// fixed lots
   LOT_MODE_MONEY,// lots based on money
   LOT_MODE_PCT_ACCOUNT// lots based on % account
};
input group "==== General ====";
static input long InpMagicnumber= 234567822;          //magic number
input double InpVolume = 0.01;                        //lots / money / percent size
input LOT_MODE_ENUM InpLotMode=LOT_MODE_FIXED;        // lot mode
input int InpStopLoss = 100;                          //stop loss
input int InpTakeProfit = 100;                        //take profit
input ENUM_TIMEFRAMES InpTimeframe = PERIOD_H1;       //Timeframe
input group "==== Coin Flip Config ====";
input int InpExeTimes = 1;                            //number of executions
input bool InpFixedRandom = false;                    //fixed random?
input group "==== AROON INDICATOR FILTER ====";
input ENUM_TIMEFRAMES InpAROONTimeframe = PERIOD_H4;  //Timeframe
input int InpAROONPeriod = 25;                        //Period (number of bars to count, 0=off)
input int InpAROONShift = 0;                          //Horizontal Shift;
input int InpAROONFilterLevel = 50;                   //Filter level in %
input bool InpAROONCloseAtNewState = false;           //Close trades at new states?

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
   if(InpAROONPeriod<0){
      Alert("Wrong input: AROON Period < 0");
      return(false);
   }
   if(InpAROONShift<0){
      Alert("Wrong input: AROON Shift < 0");
      return(false);
   }
   if(InpAROONFilterLevel<0){
      Alert("Wrong input: AROON Filter level < 0");
      return(false);
   }
   return true;
}
//+------------------------------------------------------------------+
//| Global variables                                                 |
//+------------------------------------------------------------------+
enum MARKET_STATE{
   UP_TREND,
   DOWN_TREND,
   NOT_TRENDING
};
// Trend Observation variable
MARKET_STATE curr_state;
bool new_state=false;

//AROON Indicator variables
int AROON_handle;
double AROON_Up[];
double AROON_Down[];

MqlTick currentTick;
CTrade trade;
int random_number;
bool random_signal;
int cntBuy, cntSell;
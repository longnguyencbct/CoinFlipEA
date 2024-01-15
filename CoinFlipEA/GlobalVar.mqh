//+------------------------------------------------------------------+
//| Global variables                                                 |
//+------------------------------------------------------------------+
enum MARKET_STATE{
   UP_TREND,
   DOWN_TREND,
   NOT_TRENDING_FROM_UP,
   NOT_TRENDING_FROM_DOWN
};
// Trend Observation variables
MARKET_STATE curr_state;
bool new_state=false;

//AROON Indicator variables
int AROON_handle;
double AROON_Up[];
double AROON_Down[];

// Coin Flip variables
int random_number;
bool random_signal;

// Ordinary variables
MqlTick currentTick;
CTrade trade;
int cntBuy, cntSell;

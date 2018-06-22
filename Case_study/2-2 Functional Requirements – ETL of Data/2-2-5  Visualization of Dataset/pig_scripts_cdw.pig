1) List of transaction credit card 
CreditCard_details = LOAD '/user/Credit_Card_System/CDW_SAPP_CREDITCARD/part-m-00000' 
USING PigStorage('\t') as (CUST_CC_NO:chararray, TIMEID:chararray, CUST_SSN:chararray, 
BRANCH_CODE:chararray, TRANSACTION_TYPE:chararray, 
TRANSACTION_VALUE:double, TRANSACTION_ID:int);

CreditCard_data = foreach CreditCard_details generate CUST_CC_NO, TIMEID, BRANCH_CODE, TRANSACTION_VALUE, TRANSACTION_TYPE;

Dump CreditCard_data;

2) List of New York Branches order by City

Branch_data = FOREACH Branch_details GENERATE BRANCH_CODE, BRANCH_CITY, BRANCH_STATE, BRANCH_PHONE, BRANCH_ZIP;

Branch_data_ny =FILTER Branch_data BY Branch_details.BRANCH_STATE == 'NY';

Branch_data_nyOrder = ORDER Branch_data_ny BY BRANCH_CITY; 

DUMP Branch_data_nyOrder;

3) Count number and total value of transaction by state;


Branch_creditcard = JOIN Branch_data BY BRANCH_CODE, CreditCard_data BY BRANCH_CODE; 

Branch_credit_card = FOREACH Branch_creditcard GENERATE BRANCH_STATE, TRANSACTION_TYPE, TRANSACTION_VALUE;

Branch_credit_card_grp =  GROUP Branch_creditcard BY BRANCH_STATE;

RESULTS = FOREACH Branch_credit_card_grp GENERATE COUNT(CUST_CC_NO), SUM(TRANSACTION_VALUE), BRANCH_STATE;

DUMP RESULTS;

4) Number and total transaction by transaction type in descending order

CreditCard_data_grp = GROUP CreditCard_data BY TRANSACTION_TYPE;

CreditCard_by_type = FOREACH CreditCard_data_grp GENERATE COUNT(CUST_CC_NO), SUM(TRANSACTION_VALUE), TRANSACTION_TYPE;

CreditCard_by_type_order = ORDER CreditCard_by_type BY TRANSACTION_TYPE DESC;

DUMP CreditCard_by_type_order;


 

        

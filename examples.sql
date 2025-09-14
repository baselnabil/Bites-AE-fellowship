COPY subscriptions(id,user_id,type_id,amount,start_date,expiry_date)
FROM '/home/basel/fellowship/subscriptions.csv'
DELIMITER ','
CSV HEADER;
-- CREATING TABLES : 

DROP TABLE IF EXISTS statewise_results;
DROP TABLE IF EXISTS states;
DROP TABLE IF EXISTS partywise_results;
DROP TABLE IF EXISTS constituencywise_results;
DROP TABLE IF EXISTS constituencywise_details;


CREATE TABLE states (
    State_ID VARCHAR(100) PRIMARY KEY,
    State_Name VARCHAR(100)
);


CREATE TABLE partywise_results (
    Party VARCHAR(255),
    Won INT,
    Party_ID INT PRIMARY KEY
);


CREATE TABLE statewise_results (
    Constituency VARCHAR(100),
    Const_No INT,
    Parliament_Constituency VARCHAR(100) PRIMARY KEY, -- Unique identifier
    Leading_Candidate VARCHAR(255),
    Trailing_Candidate VARCHAR(255),
    Margin INT,
    Status VARCHAR(100),
    State_ID VARCHAR(100), -- FK
    State_Name VARCHAR(100),
    FOREIGN KEY (State_ID) REFERENCES states(State_ID)
);


CREATE TABLE constituencywise_results (
    S_No INT,
    Parliament_Constituency VARCHAR(100), -- FK
    Constituency_Name VARCHAR(100),
    Winning_Candidate VARCHAR(100),
    Total_Votes INT,
    Margin INT,
    Constituency_ID VARCHAR(100), -- Unique ID
    Party_ID INT, -- FK
    PRIMARY KEY (Constituency_ID), -- Composite key
    FOREIGN KEY (Party_ID) REFERENCES partywise_results(Party_ID),
    FOREIGN KEY (Parliament_Constituency) REFERENCES statewise_results(Parliament_Constituency) -- Correct FK reference
);


CREATE TABLE constituencywise_details (
    S_N INT,
    Candidate VARCHAR(255),
    Party VARCHAR(255),
    EVM_Votes INT,
    Postal_Votes INT,
    Total_Votes INT,
    Percentage_of_Votes FLOAT,
    Constituency_ID VARCHAR(100), -- FK
    FOREIGN KEY (Constituency_ID) REFERENCES constituencywise_results(Constituency_ID)
);

-- SOLVING PROBLEM STATEMENTS : 

SELECT * FROM states ;
SELECT * FROM statewise_results;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;

-- SOLUTION : 

-- 1) Total Seats : 

SELECT DISTINCT COUNT(parliament_constituency) AS Total_Seats FROM statewise_results ;


-- 2) What is the total number of seats available for elections in each state

SELECT 
	COUNT(sr.parliament_constituency) AS Total_Seats , 
	s.state_name 
FROM states s
JOIN statewise_results sr ON s.state_id = sr.state_id 
GROUP BY 2
ORDER BY 2;

-- 3) Total Seats Won by NDA Allianz

SELECT 
	SUM(won) 
FROM 
	partywise_results
WHERE 
	  party = 'Bharatiya Janata Party - BJP' OR 
      party =  'Telugu Desam - TDP'OR   
	  party ='Janata Dal  (United) - JD(U)'OR 
      party = 'Shiv Sena - SHS'OR 
      party ='AJSU Party - AJSUP'OR  
      party = 'Apna Dal (Soneylal) - ADAL'OR   
      party ='Asom Gana Parishad - AGP'OR  
      party ='Hindustani Awam Morcha (Secular) - HAMS'OR  
	  party ='Janasena Party - JnP'OR  
	  party ='Janata Dal  (Secular) - JD(S)'OR  
      party = 'Lok Janshakti Party(Ram Vilas) - LJPRV'OR  
      party = 'Nationalist Congress Party - NCP'OR  
      party ='Rashtriya Lok Dal - RLD'OR   
      party = 'Sikkim Krantikari Morcha - SKM'
;


-- 4) Seats Won by NDA Allianz Parties

SELECT 
	party AS party_name,
	SUM(won) AS Seats_Won
FROM
	(SELECT 
		* 
	FROM 
		partywise_results
	WHERE 
	  	party = 'Bharatiya Janata Party - BJP' OR 
      	party =  'Telugu Desam - TDP'OR   
	  	party ='Janata Dal  (United) - JD(U)'OR 
      	party = 'Shiv Sena - SHS'OR 
      	party ='AJSU Party - AJSUP'OR  
      	party = 'Apna Dal (Soneylal) - ADAL'OR   
      	party ='Asom Gana Parishad - AGP'OR  
      	party ='Hindustani Awam Morcha (Secular) - HAMS'OR  
	  	party ='Janasena Party - JnP'OR  
	  	party ='Janata Dal  (Secular) - JD(S)'OR  
      	party = 'Lok Janshakti Party(Ram Vilas) - LJPRV'OR  
      	party = 'Nationalist Congress Party - NCP'OR  
      	party ='Rashtriya Lok Dal - RLD'OR   
      	party = 'Sikkim Krantikari Morcha - SKM')
GROUP BY 1
ORDER BY 2 DESC;

-- 5) Total Seats Won by I.N.D.I.A. Allianz

SELECT 
	SUM(won) 
FROM 
	partywise_results
WHERE 
	  party IN (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
	  )
;
	  
-- 6) Seats Won by I.N.D.I.A. Allianz Parties

SELECT 
	party AS party_name,
	SUM(won) AS Seats_won
FROM 
(SELECT 
	* 
FROM 
	partywise_results
WHERE 
	  party IN (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
	  )
)
GROUP BY 1
ORDER BY 2 DESC
;

-- 7) Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

ALTER TABLE partywise_results
DROP COLUMN column_name;

ALTER TABLE partywise_results
ADD Party_Allianz VARCHAR(100);

UPDATE partywise_results
SET Party_Allianz = 'NDA'
WHERE  
	  party = 'Bharatiya Janata Party - BJP' OR 
      party =  'Telugu Desam - TDP'OR   
	  party ='Janata Dal  (United) - JD(U)'OR 
      party = 'Shiv Sena - SHS'OR 
      party ='AJSU Party - AJSUP'OR  
      party = 'Apna Dal (Soneylal) - ADAL'OR   
      party ='Asom Gana Parishad - AGP'OR  
      party ='Hindustani Awam Morcha (Secular) - HAMS'OR  
	  party ='Janasena Party - JnP'OR  
	  party ='Janata Dal  (Secular) - JD(S)'OR  
      party = 'Lok Janshakti Party(Ram Vilas) - LJPRV'OR  
      party = 'Nationalist Congress Party - NCP'OR  
      party ='Rashtriya Lok Dal - RLD'OR   
      party = 'Sikkim Krantikari Morcha - SKM'
;

UPDATE partywise_results
SET Party_Allianz = 'I.N.D.I.A.'
WHERE 
	  party IN (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
	  )
;

UPDATE partywise_results
SET Party_Allianz = 'OTHER'
WHERE 
	Party_Allianz IS NULL
;

SELECT * FROM partywise_results;


-- 8) Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

SELECT * FROM states ;
SELECT * FROM statewise_results;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;

SELECT 
	party_allianz ,
	COUNT(won)
FROM 
	partywise_results pr
JOIN constituencywise_results cr ON pr.party_id = cr.party_id 
GROUP BY 1 
ORDER BY 2 DESC ;


-- 9) Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

SELECT * FROM states ;
SELECT * FROM statewise_results;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;

SELECT 
	cr.winning_candidate ,
	pr.party , 
	pr.party_allianz ,
	cr.total_votes ,
	cr.margin , 
	cr.constituency_name , 
	s.state_name 
FROM 
	constituencywise_results cr
JOIN partywise_results pr ON cr.party_id = pr.party_id 
JOIN statewise_results sr ON cr.parliament_constituency = sr.parliament_constituency 
JOIN states s ON sr.state_id  = s.state_id
WHERE s.state_name = 'Uttar Pradesh' AND cr.constituency_name = 'AMETHI';
;

-- 10) What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

SELECT * FROM states ;
SELECT * FROM statewise_results;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;


SELECT
	cd.candidate ,
	cd.evm_votes , 
	CASE
		WHEN  cd.total_votes = 0 THEN NULL 
		ELSE  (cd.evm_votes*100/cd.total_votes)::FLOAT
	END	AS Percentage_of_evm_votes ,
	cd.postal_votes ,
	CASE
		WHEN  cd.total_votes = 0 THEN NULL 
		ELSE  (cd.postal_votes*100/cd.total_votes)::FLOAT
	END	AS Percentage_of_postal_votes ,
	cd.total_votes,
	cr.constituency_name,
	cd.constituency_id
FROM 
	constituencywise_details cd 
JOIN constituencywise_results cr ON cd.constituency_id = cr.constituency_id
ORDER BY cr.constituency_name
;



-- 11) Which parties won the most seats in s State, and how many seats did each party win?


SELECT
	pr.party_allianz ,
	s.state_name,
	COUNT(cr.parliament_constituency)
FROM 
	states s 
JOIN statewise_results sr ON s.state_id = sr.state_id 
JOIN constituencywise_results cr ON sr.parliament_constituency = cr.parliament_constituency
JOIN partywise_results pr ON cr.party_id = pr.party_id 
GROUP BY 1,2
ORDER BY 3 DESC
;

	

-- 12) What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

SELECT
	pr.party,
	COUNT(cr.parliament_constituency)
FROM 
	states s 
JOIN statewise_results sr ON s.state_id = sr.state_id 
JOIN constituencywise_results cr ON sr.parliament_constituency = cr.parliament_constituency
JOIN partywise_results pr ON cr.party_id = pr.party_id 
WHERE s.state_id LIKE 'S%'
GROUP BY 1
ORDER BY 2 DESC
;

-- 13) Which candidate received the highest number of EVM votes in each constituency (Top 10)?
SELECT * FROM states ;
SELECT * FROM statewise_results;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;

SELECT 
	cr.constituency_name,
	cd.candidate,
	MAX(cd.evm_votes),
	cd.constituency_id
FROM
	constituencywise_details cd 
JOIN constituencywise_results cr ON cd.constituency_id = cr.constituency_id
GROUP BY 1,2,4
ORDER BY 3 DESC
LIMIT 10;


-- 14) Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
SELECT * FROM states ;
SELECT * FROM statewise_results;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;

SELECT 
	constituency_name,
	candidate,
	total_votes,
	constituency_id
FROM
(SELECT 
	cr.constituency_name,
	cd.candidate,
	cd.total_votes,
	cd.constituency_id,
	ROW_NUMBER() OVER (PARTITION BY cd.constituency_id ORDER BY cd.total_votes DESC ) AS rK
FROM
	constituencywise_results cr
JOIN constituencywise_details cd ON cd.constituency_id = cr.constituency_id)
WHERE rk < 3
;

-- 15) For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?

SELECT * FROM states ;
SELECT * FROM statewise_results;
SELECT * FROM partywise_results;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;


SELECT 
	COUNT( DISTINCT cr.parliament_constituency) AS Total_Seats,
	COUNT( DISTINCT cd.candidate) AS Total_Candidates,
	COUNT(DISTINCT pr.party) AS Number_Of_Parties,
	SUM(cd.total_votes) AS Total_Votes ,
	SUM(cd.evm_votes) AS Total_EVM_Votes,
	SUM(cd.postal_votes) AS Total_Postal_Votes
FROM 
	constituencywise_details cd
JOIN constituencywise_results  cr ON cd.constituency_id = cr.constituency_id
JOIN partywise_results pr ON cr.party_id = pr.party_id
JOIN statewise_results sr ON cr.parliament_constituency = sr.parliament_constituency
JOIN states s ON sr.state_id = s.state_id
WHERE s.state_name = 'Maharashtra';
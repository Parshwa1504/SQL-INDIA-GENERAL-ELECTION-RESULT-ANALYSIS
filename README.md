# SQL-INDIA-GENERAL-ELECTION-RESULT-ANALYSIS

## Project Overview

**Project Title**: INDIA GENERAL ELECTION RESULT ANALYSIS
**Database**: `India_Election_DB`

This project demonstrates the implementation of India General Election Result Analysis using SQL.The project involves creating and managing normalized database tables to analyze Indian election data. Tasks include performing CRUD operations, executing complex SQL queries for insights, and addressing specific problem statements. The code demonstrates advanced SQL skills in database design, querying, and generating actionable insights for electoral analysis.

## Objectives

1. **Database Design**: Create normalized database tables with appropriate relationships and constraints to store election data effectively.
2. **Data Retrieval**: Execute complex SQL queries to analyze election outcomes, such as total seats won by alliances and vote distribution.
3. **Insight Generation**: Derive actionable insights from data, including party performance, candidate standings, and state-wise election statistics.
4. **Query Optimization**: Optimize SQL queries for efficient data retrieval and analysis across large datasets.

## Project Structure

### 1. Database Setup
![ERD](https://github.com/Parshwa1504/SQL-INDIA-GENERAL-ELECTION-RESULT-ANALYSIS/blob/main/SQL_India_Election_Result_ERD.png)

- **Database Creation**: Created a database named `India_Election_DB`.
- **Table Creation**: Created tables for states, partywise_results, statewise_results, constituencywise_results, constituencywise_details . Each table includes relevant columns and relationships.

```sql
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
```

### 2. ANALYSIS AND SOLVING ANALYTICAL PROBLEMS RELATED TO AMAZON DATASET :

**Task 1 : Total Seats**

**Task 2: What is the total number of seats available for elections in each state**

**Task 3: Total Seats Won by NDA Allianz**

**Task 4: Seats Won by NDA Allianz Parties**

**Task 5: Total Seats Won by I.N.D.I.A. Allianz**

**Task 6: Seats Won by I.N.D.I.A. Allianz Parties**

**Task 7: Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER**

**Task 8: Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?**

**Task 9: Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?**

**Task 10: What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?**

**Task 11: Which parties won the most seats in s State, and how many seats did each party win?**

**Task 12: What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024**

**Task 13: Which candidate received the highest number of EVM votes in each constituency (Top 10)?**

**Task 14: Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?**

**Task 15: For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?**

## Conclusion

The India General Election Result Analysis project demonstrates advanced SQL skills by creating a normalized database to analyze election data. It provides insights into party performance, vote distribution, and alliance dominance. Optimized queries ensure efficient analysis, making this a robust framework for extracting actionable insights from electoral data.

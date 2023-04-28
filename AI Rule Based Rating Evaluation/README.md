# Domain: Football Players Rating Evaluation

This AI rule-based method is intended to predict a football player's likelihood of fitting
in well with the team. Each player in this system is required to pass three
examinations, including a passing test, a pace test, and a fitness test. These three
criteria have been taken into account because they are essential for playing
football. In addition to these factors, the players' ages and relevant experience are
also considered when determining their skill levels. Each factor has a different
weighting and can be easily adjusted to meet the needs. The overall rating system is
demanding since it calls for players to be exceptional in order to join elite clubs and
advance their careers.

# Features of the system

This AI system is created in a way to engage a user by letting the user enter specific
scores. The system then computes the player's final rating and suggests whether
he/she should be purchased to play for the team or not. The system's numerous
input values include:

● Player’s age

● Player’s relevant years of experience

● Player’s score on the pace test, between 1 and 10

● Player’s score on the passing test, between 1 and 10

● Player’s score on the fitness test, between 1 and 10

We execute the rule engine, which has rules pertaining to all possible combinations
of values for these five parameters after we have collected all of the user scores.
Based on the importance of each of these factors, the system assesses the
employee's overall rating and makes a suggestion. As previously noted, the five
factors are given various levels of importance or weight according to their logical
value to the final grade.

## The different weights given to these factors are

● Player’s age: 15%

● Player’s relevant years of experience: 15%

● Fitness Rating: 30%

● Passing Score: 20%

● Pace Score: 20% 

## Knowledge Base
The knowledge base used by this AI system consists of the following:
Facts:

1. Questions: This comprises questions that are given an id to identify
them and a type that indicates the kind of response the system
anticipates. The different questions are:

● What is the age of the player?

● How many years of experience does the player have that is
relevant?

● What was the player's pace test score?

● What was the player's passing test score?

● What was the player's fitness test score?

## Templates:

1. Candidate template: This template stores all the information for a
player, namely their age, relevant experience, pace score, passing
score, and fitness score.

2. Question template: This maintains the format in which the questions
must be asked by the user.

3. Answer template: This is where the user-provided responses to the
questions are kept.

4. Rating template: This contains the employee's final rating following
computation and consideration of all relevant information.

5. Recommendation template: This stores the final recommendation and
includes slots for the rating and the final recommendation.

## Rules and Description

### No. Rules Description

1 ask-question-by-id Ask a question from the user

2 welcome-user Prints the welcome message

3 request-age Request the player's age

4 request-experience Request the player's experience

5 request-pace-score Request the player's pace-score

6 request-passing-score Request the player's passing-score

7 request-fitness-score Request the player's fitness-score

8 assert-candidate-fact Assert the candidate's information

9 rating-combination[1-19] 19 rules to determine the rating and evaluation of the player

10 check-experience Check if the experience value is logically correct with respect to the age

11 print-result Print out the result of the player evaluation

## Sample Test Cases:

### 1. Test Case 1

● Age: 25

● Fitness test score: 8

● Passing test score: 9

● Pace test score: 8

● Years of experience: 7

### 2. Test Case 2
● Age: 35
● Fitness test score: 10

● Passing test score: 10

● Pace test score: 10

● Years of experience: 15

### 3. Test Case 3
● Age: 29

● Fitness test score: 9

● Passing test score: 9

● Pace test score: 9

● Years of experience: 12

## Key for running the tests:

● Try out any test case with fitness, passing, and pace test scores to be between 1 - 10.

● Player with a rating of 7 and below is “Low Performance, Not Suitable for team”.

● Player with a rating of 8 has “Good Performance, Recommended for team”.

● Player with a rating of 9 is “High Performance, Good Fit for team”.

● Player with a rating of 10 is “High Performance, Perfect for team”.

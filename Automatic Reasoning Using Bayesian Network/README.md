# Domain: Football Players Rating Evaluation using Bayesian network automatically reasoning

## 1. Description

This project is intended to predict a football player's likelihood of fitting in well at a
particular position in the team. We consider six basic attributes that a football player
should have:

● Passing skills,

● Pace of player,

● Physical skill of the player,

● Defending skills,

● Dribbling skills,

● Shooting skills.

These skills are generally used by football games to define a player's overall skill.
Similar to the image below, where the skills are mentioned for the player.


A player can be an attacker, midfielder, defender, all-rounder, or goalkeeper. We
won't be checking if a player is fit to be a goalkeeper because they come in a
different category altogether. However, based on the six skills mentioned above, we
will try to determine if a player is suitable to be an attacker, midfielder, defender, or
all-rounder. We will also consider a player’s age to determine their suitable playing
position.

We will also take into account some other attributes of the player, which will help us
determine an outcome for the player. These attributes include

● Whether or not a player is a team player,

● Game understanding, in general, and

● Decision-making skills

All the above information is the same as in the previous project. For the decision
network, I have added five extra nodes – the “AllRounder” node,
“BehaviouralAttribute” node, “DecisionMaking” node, and “PositionCDM”, and
“PositionCAM” nodes. The first node is a decision node, the next two are nature
nodes, and the last two are utility nodes.

The " AllRounder " decision node is modeled in a way that a player can be an allrounder if he/she excels as a midfielder, attacker, and defender.

● If a player is an allrounder and a good defender, then the utility is more for it to play as a central defensive midfielder.

● If a player is an allrounder and a good attacker, then the utility is more for it to play as a central attacking midfielder.

## 2. Explanation of the variables/nodes

### There are 20 nodes in total:

● The 6 nodes “Passing”, “Pace”, “Physical”, “Defending”, “Dribbling,” and “Shooting”, each have two states — Great or Bad.

● We also have 3 nodes to determine the player's overall skills based on the six basic skill attributes.

○ The “AttackingAttributes” node is an aggregate of the “Dribbling” and “Shooting” nodes.

○ The “DefendingAttributes” node is an aggregate of the “Physical” and “Defending” nodes.

○ The “BasicAttributes” node is an aggregate of the “Passing” and “Pace” nodes.

● The “TeamPlayer”, “UnderstandingGame” and “DecisionMaking” nodes are extra nodes that help us determine the player’s suitable position in the team.

### ● The node “Age” has three states:

○ Age between 10 and 20

○ Age between 20 and 30

○ Age between 30 and 40

● The 4 nodes “Defender”, “Attacker”, “Midfielder” and “AllRounder”, are direct predictors of the possible player’s position.

● The 2 utility nodes “PositionCDM” and “PositionCAM” are needed to decide if a player can be suitable for the central defensive midfielder (CDM) or central
attacking midfielder (CDM) if he is a good defender and an allrounder or a good attacker and an allrounder respectively.

### 3. Describe the Dependency/Independence among variables

Node(s) Dependency Independence

Passing

Pace

Physicality

Defending

Dribbling

Shooting
- Yes

AttackingAttributes

1. Dribbling

2. Shooting
-

DefendingAttributes

1. Physicality

2. Defending
-

BasicAttributes

1. Passing

2. Pace

-

Age

UnderstandingGame

TeamPlayer

DecisionMaking

- Yes

BehaviouralAttribute

1. UnderstandingGame

2. TeamPlayer

3. DecisionMaking

Midfielder

1. DefendingAttributes

2. AttackingAttributes

3. Age

4. BehaviouralAttribute

-

Defender

1. DefendingAttributes

2. BasicAttributes

3. Age

4. BehaviouralAttribute

-

Attacker

1. AttackingAttributes

2. BasicAttributes

3. Age

4. BehaviouralAttribute
-

AllRounder

1. Defender

2. Attacker

3. Midfielder

-

PositionCDM

1. AllRounder

2. Defender

-

PositionCAM

1. AllRounder

2. Attacker

-

4. Instructions to run the file:

● Open the file in Netica. File -> Open

● Go to Network -> Compile

● Now that the network is ready, you can play around with it by changing the probabilities of different nodes and see how this affects the overall probability

of a player being chosen as an attacker, defender, or a midfielder.

## Note: For a node's explanation, kindly check the corresponding probability tables to see how the values are obtained.

## When you compile the Bayesian network, you will see a network like the one shown below.

## 5. Sample Test Cases:
### 1. Test Case 1
Here is a player who is a Defender and is also a good allrounder. Therefore, the player is more likely to be a central defensive midfielder.

### 2. Test Case 2
Here is a player who is an Attacker and is also a good allrounder. Therefore, the player is more likely to be a central defensive midfielder.

### 3. Test Case 3
Here is a player who is equally likely to be an Attacker and a Defender and is also a good allrounder. Therefore, the player can be a central defensive
midfielder or a central attacking midfielder.

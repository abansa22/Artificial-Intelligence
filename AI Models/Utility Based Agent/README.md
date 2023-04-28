In this project, a hypothetical forward search is done and based on the probability value at
each stage, the search is done. The process function in the AgentFunction file has been
modified. We have defined the actions to be done based on the situations.


The action table consists of the following:

actionTable[0] = Action.NO_OP;

actionTable[1] = Action.GO_FORWARD;

actionTable[2] = Action.GO_FORWARD;

actionTable[3] = Action.GO_FORWARD;

actionTable[4] = Action.TURN_RIGHT;

actionTable[5] = Action.TURN_LEFT;

actionTable[6] = Action.GRAB;

actionTable[7] = Action.SHOOT;

Based on this, We are deciding the action to do. We always check if the location has glitter,
if so then we are grabbing it. That’s the initial condition. Then, we are checking if there is no
bump and no glitter and no breeze and no stench and no scream, we are then moving
forward. If there is a stench, it means that the wumpus is near. So, there are two
possibilities for this. The agent can shoot or do no actions. If there is an arrow, the agent
shoots otherwise no actions are performed. If there is a scream and there is no breeze, it
means that there is no one on the way and the agent can move forward. Else, there is no
action taken.

Note: The functions used in the code have been commented on and explained in detail in
the code file itself.

Sample Outputs:

The project was run and the following results were received:

No. of trials: 10000

Total Score: 1386482

Average Score: 138.6482

Total Score: 1458664

Average Score: 145.8664

Total Score: 1394561

Average Score: 139.4561

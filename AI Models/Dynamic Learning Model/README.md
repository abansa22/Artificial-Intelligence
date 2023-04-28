In this project, an agent has been implemented which does learning over various timesteps
and learns from it. The track of previous movements is kept with a class called
previousMove.

Also, we are keeping track of the previous result. It can be a right move or a wrong move. A
wrong move is the one where the agent gets -100, while a right move is the one where the
agent gets a positive reward. We are also keeping track of this using another class called
prev. It has three fields:

● RIGHT

● WRONG, and

● ONELESS

We have another one with states and we are categorizing them as Listen, OpenRight,
OpenLeft, MayBeLeft, and MayBeRight. Based on this, a code has been written and we are
making sure that the agent does more right moves than the wrong moves.

Sample Outputs:

The project was run and the following results were received:

Ran for - No. of trials: 10000 and 100 steps

Total Score: 5439662
Average Score: 543.9662
Total Score: 5502767
Average Score: 550.2767

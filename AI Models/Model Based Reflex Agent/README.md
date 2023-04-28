Description of project:
Amodel is constructed as our agent navigates through the environment and performs its
actions based on the precepts and state of the environment.
Approach:
We define multiple variables to keep track of the actions, initialize a 4x4 world,
envArray. Then we add a new random number generator, for randomly picking actions
to execute. We choose different actions based on the thing in our grid. We iteratively
store the locations of the previous and new steps and find safe cells that our agent can
move on. We have the updateDirection function which updates the direction based on
the action. The updateLoc function updates the location. The neighbors function fills the
envArray which is the world of our agent. Finally, the breezeAction function lets us
decide which action to take based on the direction of the agent.

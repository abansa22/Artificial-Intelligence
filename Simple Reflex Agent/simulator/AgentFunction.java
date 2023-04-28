/*
 * Class that defines the agent function.
 * 
 * Written by James P. Biagioni (jbiagi1@uic.edu)
 * for CS511 Artificial Intelligence II
 * at The University of Illinois at Chicago
 * 
 * Last modified 2/19/07 
 * 
 * DISCLAIMER:
 * Elements of this application were borrowed from
 * the client-server implementation of the Wumpus
 * World Simulator written by Kruti Mehta at
 * The University of Texas at Arlington.
 * 
 */

import java.util.Random;

class AgentFunction {
	
	// string to store the agent's name
	// do not remove this variable
	private String agentName = "Agent Carter";
	
	// all of these variables are created and used
	// for illustration purposes; you may delete them
	// when implementing your own intelligent agent
	private int[] actionTable;
	private boolean bump;
	private boolean glitter;
	private boolean breeze;
	private boolean stench;
	private boolean scream;
	private Random rand;

	public AgentFunction()
	{
		// for illustration purposes; you may delete all code
		// inside this constructor when implementing your 
		// own intelligent agent

		// this integer array will store the agent actions
		actionTable = new int[8];
				  
		actionTable[0] = Action.NO_OP;
		actionTable[1] = Action.GO_FORWARD;
		actionTable[2] = Action.GO_FORWARD;
		actionTable[3] = Action.GO_FORWARD;
		actionTable[4] = Action.TURN_RIGHT;
		actionTable[5] = Action.TURN_LEFT;
		actionTable[6] = Action.GRAB;
		actionTable[7] = Action.SHOOT;
		
		// new random number generator, for
		// randomly picking actions to execute
		rand = new Random();
	}

	public int process(TransferPercept tp)
	{
		// To build your own intelligent agent, replace
		// all code below this comment block. You have
		// access to all percepts through the object
		// 'tp' as illustrated here:
		
		// read in the current percepts
		bump = tp.getBump();
		glitter = tp.getGlitter();
		breeze = tp.getBreeze();
		stench = tp.getStench();
		scream = tp.getScream();
		int action = 0;

		rand = new Random();
		int[] ifBumpAction = new int[]{ 4,5 };
		
		// we will be checking if the location has glitter, if yes then we will be grabbing it
		if (glitter == true) { 
			action = 6;
		}

		// if there is no bump, breeze or stench, scream and no glitter then we will just move for forward
		else if (!(bump == true || glitter == true || breeze == true || stench == true || scream == true)) {
			action = 1;
		} 
		
		else {
			//  if there is bump, we will randomly choose to turn right or left.
			if (bump == true) {
				action = ifBumpAction[rand.nextInt(2)];
			}

			// if there is a stench, then we know that the wumpus is nearby. Our agent can either shoot or not do anything. 
			// Our agent will shoot only 15% of the time so we will generate a random value to decide whether to shoot or do nothing.
			else if (stench == true) {
				double shootProb = Math.random();  // generate a random value
				
				// shoot the wumpus
				if (shootProb < 0.15) { 
					action = 7;
				}
				// do nothing
				else {
					action = 0;
				}
			} 
			
			// there is no one on our agent's path if there is a scream with no breeze, so our agent will move forward
			else if(scream == true && breeze == false) {
				//move forward
				action = 1;
			} 
			
			// else we will take no action
			else {
				// no operation
				action = 0;
			}
		}

		return actionTable[action];   
	}
	
	// public method to return the agent's name
	// do not remove this method
	public String getAgentName() {
		return agentName;
	}
}
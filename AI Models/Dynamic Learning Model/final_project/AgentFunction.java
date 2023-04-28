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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

class Game{
	public int score;
	public ArrayList<Integer> actionList = new ArrayList<>();
}

class GameList{
	ArrayList<Game> gmList = new ArrayList<>();
}

class AgentFunction {
	previousMove prev;
	public enum previousMove{
		WRONG, RIGHT, ONELESS
	}

	previousMove prevmove;
	
	public enum prevMove{
		OPENLEFT, OPENRIGHT, LISTEN
	}
	
	lastMoveSteps lastMoveStepsWere;
	
	public enum lastMoveSteps{
		TWOSTEPS, THREESTEPS
	}

	int[] threeStepsArray = new int[3];
	int[] twoStepsArray = new int[2];
	static int count = 0;
	static HashMap<Integer, GameList> map= new HashMap<>();
    static HashMap<Integer, ArrayList<Integer>> possibileSequence = new HashMap<>();
    static HashMap<Integer, Integer> scoreMap = new HashMap<>();
	public static void init() {
		//Called at the start of the program
	
	}
	
	public AgentFunction() {
		count+=1;
	}

	static int leftGrowlCount =0;
	static int rightGrowlCount = 0;
	static int rightMoves = 0;
	static int wrongMoves = 0;
	Game g = new Game();
	int ignoreValue = -1;
	int dontIgnoreValue = -1;
	GameList gm = new GameList();
	int timestepCount = 0;
	
	int observations;
	private int state;
	
	possibleState s;
	public enum possibleState {
		Listen, OpenRight, OpenLeft, MayBeLeft, MayBeRight
	}

	possibleState parentState;
	possibleState dangerousState;
	stateObserved stateObs;
	public enum stateObserved {
		stateObservedNow, stateNotObservedNow
	}

	public int process(int score, boolean growlLeft, boolean growlRight) {
		scoreMap.put(timestepCount, score);
		
		if(scoreMap.get(timestepCount - 1)!=null) {
			System.out.println("PREV - CURRENT"+ (score - scoreMap.get(timestepCount - 1)));
			if(score - scoreMap.get(timestepCount - 1)== -100 || score - scoreMap.get(timestepCount - 1)== 100 ) {
				System.out.println("WRONG");
				wrongMoves+=1;
				prev = previousMove.WRONG;
			}

			else if(score - scoreMap.get(timestepCount - 1)==-10 || score - scoreMap.get(timestepCount - 1)== 10) {
				System.out.println("RIGHT");
				rightMoves+=1;
				prev = previousMove.RIGHT;
			}

			else {
				prev = previousMove.ONELESS;
			}
		}
		timestepCount+=1;
		if(prev == previousMove.WRONG ) {
			if(s == possibleState.MayBeRight) {
				parentState = possibleState.Listen;
			}
			else if(s == possibleState.MayBeLeft) {
				parentState = possibleState.Listen;
			}
			else if(s== possibleState.OpenLeft) {
				parentState = possibleState.MayBeLeft;
			}
			else if(s==possibleState.OpenRight) {
				parentState = possibleState.MayBeRight;
			}
			
			if(parentState!=null) {
				dangerousState = parentState;
				
			}
		}

		if(s == possibleState.MayBeRight) {
			if(growlLeft==true && dangerousState == null) {
				g.actionList.add(0);
				s = possibleState.OpenRight;
				return Action.OPEN_RIGHT_DOOR;
				
			}
			else if(growlRight==true) {  
				g.actionList.add(1);
				s = possibleState.Listen;
				
			}

			dangerousState= null;
			return Action.LISTEN;
		}

		if(s == possibleState.MayBeLeft) {
			if(growlLeft==true) {
				g.actionList.add(0);
				s = possibleState.Listen;
				
			}
			if(growlRight==true && dangerousState == null) {
				g.actionList.add(1);
				s = possibleState.OpenLeft;
				return Action.OPEN_LEFT_DOOR;
			}
			dangerousState= null;
			return Action.LISTEN;
		}
		
		if(s == possibleState.OpenRight) {
			
			s = possibleState.Listen;
			return Action.LISTEN;
		}
		
		if(s == possibleState.OpenLeft) {
			s = possibleState.Listen;
			return Action.LISTEN;
		}

		if(stateObs != stateObserved.stateObservedNow || stateObs==null || s == possibleState.Listen) { 
			dangerousState=null;
			if(growlLeft==true) {
				g.actionList.add(0);
				s = possibleState.MayBeRight;
			}
			if(growlRight==true) {
				g.actionList.add(1);
				s = possibleState.MayBeLeft;
			
			}
			return Action.LISTEN;
		}
		s= possibleState.Listen;
		return Action.LISTEN;
	}
	
	public void cleanup(int score) {
		System.out.println("Count"+count);
		g.score =score;
		gm.gmList.add(g);
		
		map.put(count, gm);
		
	}
	
	public static void exit() {
		System.out.println("RIGHT MOVES"+rightMoves);
		System.out.println("WRONG MOVES"+wrongMoves);
		
	}
}
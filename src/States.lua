-----------------------------------------
-- Describes a series of States objects can be in.
-- Must follow the state machine format.



-----------------------------------------------
-- State.
local State = {}
function State.on_enter(obj) end
function State.on_update(obj, dt) end
function State.on_exit(obj) end



-----------------------------------------------
-- SeekState : State
local SeekState = {}

function SeekState.on_enter(obj)
	print "Starting to seek target"
end

function SeekState.on_update(obj, dt)
	-- Update and move towards the target
end

function SeekState:on_exit(obj)
	-- Set the target to nil?
	print "Stop seeking target"
end



----------------------------
-- AttackState : State
-- Attacks based on attack amount and timer.
local AttackState = {}
function AttackState.on_enter(obj) end
function AttackState.on_update(obj, dt) end
function AttackState.on_exit(obj, dt) end



----------------------------
-- MovingState : State
-- Moves.
local MovingState = {}
function MovingState.on_enter(obj) end
function MovingState.on_update(obj, dt) end
function MovingState.on_exit(obj, dt) end


--------------------------------
-- A list of State functions.
return {
	STATE = State,
	SEEKER = SeekState,
	ATTACK = AttackState,
	MOVE = MovingState,
}

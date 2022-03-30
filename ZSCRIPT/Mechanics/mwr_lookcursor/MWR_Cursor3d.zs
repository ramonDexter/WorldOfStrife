class MWR_Cursor3dInv : Inventory
{
	private Actor _cursor;
	private bool bCursorEnabled;
	protected bool bCursorRequestEnabled;
	protected bool bCursorHit;
	protected FLineTraceData tCursorHit;
	
	int CursorRange;
	int TraceFlags;
	string CursorClassName;
	
	property CursorRange : CursorRange;
	property CursorTraceFlags : TraceFlags;
	property CursorClassName : CursorClassName;

	Override Void PostBeginPlay(){
		Super.PostBeginPlay();
		If (CursorRange <= 0) {CursorRange = 4096;}
		If (TraceFlags <= 0) {TraceFlags = TRF_THRUHITSCAN | TRF_NOSKY | TRF_ALLACTORS;}
		if (!CursorClassName) {CursorClassName = 'MWR_Cursor3d';}
	}
	
	override void Tick(){
		Super.Tick();

		if (Owner == null || Owner.player == null){
			return;
		}
		
		if (bCursorRequestEnabled){
			if (!bCursorEnabled){
				bCursorEnabled=true;
				Show3dCursor();
				DoAfterEnable();
				DoWhileEnabled();
			} else {
				Show3dCursor();
				DoWhileEnabled();
			}
		} else {
			if (bCursorEnabled){
				bCursorEnabled=false;
				DoBeforeDisable();
				Hide3dCursor();
			} else {
				Hide3dCursor();
			}
		}
		
	}
	
	virtual void DoAfterEnable(){}

	virtual void DoWhileEnabled(){}

	virtual void DoBeforeDisable(){}
	
	//request the cursor to be enabled. Return tells if the cursor is currently enabled.
	bool EnableCursor(){
		//console.printf('Start Cursor');//DEBUG
		bCursorRequestEnabled=true;
		return bCursorEnabled;
	}
	
	//request the cursor to be disabled. Return tells if the cursor is currently enabled.
	bool DisableCursor(){
		//console.printf('Stop Cursor');//DEBUG
		bCursorRequestEnabled=false;
		return bCursorEnabled;
	}
	
	//For debugging
	string getHitDescription(){
		if (!bCursorHit){
			return '[nothing]';
		} else {
			switch (tCursorHit.HitType)
			{		
				case TRACE_HitNone:
					return '[nothing]';
				case TRACE_HitFloor:
					return '[floor]'..tCursorHit.HitTexture;
				case TRACE_HitCeiling:
					return '[ceiling]'..tCursorHit.HitTexture;
				case TRACE_HitWall:
					return '[wall]'..tCursorHit.HitTexture;
				case TRACE_HitActor:
					return '[actor]'..tCursorHit.HitActor.getTag();
				default:
					return '[unknown]';
			}
		}
	}
	
	private void Show3dCursor(){

		bCursorHit = Owner.LineTrace(
			Owner.Angle, 
			CursorRange, 
			Owner.Pitch, 
			TraceFlags,
			Owner.player.viewheight,
			data: tCursorHit
		);

		if (bCursorHit){
			double ang, pt, roll;
			[ang, pt, roll] = GetHitAnglePitchRoll(tCursorHit, Owner);
			vector3 offsetVector = (0,0,0);
			
			//trying to offset the cursor to center it on a pixel
			//double offset=0.35;
			//offsetVector = (offset*sin(ang),offset*-cos(ang),offset);
			
			//pull the cursor back 1 map unit to keep it "outside" what it hit
			offsetVector=-1*tCursorHit.HitDir;
			
			vector3 CursorPos=tCursorHit.HitLocation+offsetVector;
			
			if (_cursor == null){
				_cursor = Spawn(CursorClassName, CursorPos);
			} else {
				_cursor.SetOrigin(CursorPos, true);
			}
			
			if (_cursor != null){
				_cursor.Angle = ang;
				_cursor.Pitch = pt;
				_cursor.Roll = roll;
			}
		} else {
			Hide3dCursor();
		}
	}

	private void Hide3dCursor(){
		if (_cursor != null) {
			_cursor.Destroy();
		}
	}

	private static double, double, double GetHitAnglePitchRoll(FLineTraceData t, Actor source){
		double ang, pt, roll;

		switch (t.HitType){		
			case TRACE_HitFloor:
			case TRACE_HitCeiling:
				[ang, pt, roll] = GetHitAnglePitchRollFromPlane(t, source);
				break;
			case TRACE_HitWall:
				[ang, pt, roll] = GetHitAnglePitchRollFromLine(t);
				break;
			default:
				return 180+source.angle, 270-source.pitch, 0;
		}

		return ang, pt, roll;
	}

	private static double, double, double GetHitAnglePitchRollFromPlane(FLineTraceData t, Actor source){
		bool is3dfloor = t.Hit3DFloor != null;
		SecPlane p;

		if (is3dfloor){
			p = t.HitType == TRACE_HitFloor ? t.Hit3DFloor.top : t.Hit3DFloor.bottom;
		} else if (t.HitType == TRACE_HitFloor){
			p = t.HitSector.floorplane;
		} else { // if (t.HitType == TRACE_HitCeiling)
			p = t.HitSector.ceilingplane;
		}

		let n = p.Normal;
		if (is3dfloor){n=-1*n;}
		
		double ang = 0, pt = -asin(n.Z);

		if (n.XY.Length() > 0){
			ang = atan2(n.Y, n.X);
		}

		double roll = source.Angle + 180 - ang;
		return ang, pt - 90, pt > 0 ? roll : -roll;
	}

	private static double, double, double GetHitAnglePitchRollFromLine(FLineTraceData t){
		let delta = t.HitLine.delta;
		double ang = atan2(delta.Y, delta.X);
		return ang + (t.LineSide == Line.front ? -90 : 90), -90, 0;
	}
}

class MWR_Cursor3d : Actor
{
	Default{
		+NOINTERACTION;
		+FLATSPRITE;
		Scale 0.45;
		Renderstyle "Translucent";
		Alpha 0.65;
	}

	States{
		Spawn:
			CRSR A -1 Bright; //Cursor A 4-pointer
			//CRSR B -1 Bright; //Cursor B cross
			//CRSR C -1 Bright; //Cursor C pistol
			stop;
	}
}

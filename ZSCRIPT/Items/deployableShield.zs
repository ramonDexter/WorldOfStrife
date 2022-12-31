////////////////////////////////////////////////////////////////////////////////
//  deployable shield  /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
Submitted: David Raven
Decorate: Captain Toenail, David Raven
Sounds: Quake 2, Half Life
Sprites: Doom, Duke3D, Rogue Entertainment
Sprite Edit: Captain Toenail, scalliano, David Raven
Idea Base: David Raven
*/
////////////////////////////////////////////////////////////////////////////////
//const DeployableShieldWeight = 95;
////////////////////////////////////////////////////////////////////////////////

// inventory item //////////////////////////////////////////////////////////////
class wosDeployableShield : wosPickup {
	Default {
		//$Category "Powerups/WoS"
		//$Title "Deployable Shield"		
		
		+INVENTORY.INVBAR;
		Tag "$T_DEPLSHIELD";
		Inventory.Icon "I_DEPS";
		Inventory.PickupMessage "$F_DEPLSHIELD";
		Mass DeployableShieldWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 1 A_SpawnItemEx("ActiveShield", 56, 0, 8, 0, 0, 0, 0, 1);
			Stop;
  }
}

// dummy decoration ////////////////////////////////////////////////////////////
class wosD_DeployableShieldDummy : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "Deployable Shield dummy"
		Tag "$T_DEPLSHIELD";
		Radius 4;
		Height 8;
		+SOLID;
		+NOGRAVITY;
		+USESPECIAL;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}

// shield mechanics ////////////////////////////////////////////////////////////
class PShieldPart : actor {
	Default {
		+SHOOTABLE
		+NOGRAVITY
		+NOTELEPORT
		+NODAMAGE
		+NORADIUSDMG
		+DONTRIP
		+NOBLOODDECALS
		+FLOORCLIP	
		+GHOST	//Give projectiles that you wish to pass through the shield THRUGHOST flag
		
		Radius 10;
		Height 16;
		Scale 0.5;
		RenderStyle "None";
		Alpha 0.25;
		Bloodtype "PShieldHit";	
	}
	
	States {
		Spawn:
			HEXA A 4 Bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}
class PShieldPartVisual : actor {
	Default {
		+NOINTERACTION
		+CLIENTSIDEONLY
		+FLOORCLIP
		
		Radius 8;
		Height 8;
		Scale 0.5;
		RenderStyle "Add";
		Alpha 0.25;		
	}
	
	States {
		Spawn:
			HEXA A 4 bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}

class PShieldSpawner5up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;		
	}
	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 64, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 64, 0, 0, 0, 0, 32);
			stop;
	}
}

class PShieldSpawner4up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;	
	}
	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 56, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 56, 0, 0, 0, 0, 32);
			stop;
	}
}

class PShieldSpawner3up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}
	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("PShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			stop;
	}
}

class PShieldHit : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
		Scale 0.5;
		Renderstyle "Add";
	}
	
	States {
		Spawn:
			FHIT A 0 bright;
			FHIT A 1 bright A_Stop();
			FHIT A 0 bright A_StartSound ("ForceBarrier/Hit", 0);
			FHIT BCDEFGH 1 bright;
			stop;
	}
}

// 33% red part ////////////////////////////////////////////////////////////////
class RedAPShieldPart : actor {
	Default {
		+SHOOTABLE
		+NOGRAVITY
		+NOTELEPORT
		+NODAMAGE
		+NORADIUSDMG
		+DONTRIP
		+NOBLOODDECALS
		+FLOORCLIP
		+GHOST	//Give projectiles that you wish to pass through the shield THRUGHOST flag
		
		Radius 10;
		Height 16;
		Scale 0.5;
		RenderStyle "None";
		Alpha 0.25;
		Bloodtype "RedAPShieldHit";
	}	
	States {
		Spawn:
			HEXP A 4 bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}
class RedAPShieldPartVisual : actor {
	Default {
		+NOINTERACTION
		+CLIENTSIDEONLY
		+FLOORCLIP
		
		Radius 8;
		Height 8;
		Scale 0.5;
		RenderStyle "Add";
		Alpha 0.25;
	}	
	States {
		Spawn:
			HEXP A 4 bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}	
class RedAPShieldSpawner5up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 64, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 64, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedAPShieldSpawner4up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 56, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 56, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedAPShieldSpawner3up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedAPShieldHit : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
		Scale 0.5;
		Renderstyle "Add";
	}	
	States {
		Spawn:
			FHIP A 0 bright;
			FHIP A 1 bright A_Stop();
			FHIP A 0 bright A_StartSound ("ForceBarrier/Hit", 0);
			FHIP BCDEFGH 1 bright;
			stop;
	}
}

// 66% red part ////////////////////////////////////////////////////////////////
class RedBPShieldPart : actor {
	Default {
		+SHOOTABLE
		+NOGRAVITY
		+NOTELEPORT
		+NODAMAGE
		+NORADIUSDMG
		+DONTRIP
		+NOBLOODDECALS
		+FLOORCLIP
		+GHOST	//Give projectiles that you wish to pass through the shield THRUGHOST flag
		
		Radius 10;
		Height 16;
		Scale 0.5;
		RenderStyle "None";
		Alpha 0.25;
		Bloodtype "RedBPShieldHit";
	}	
	States {
		Spawn:
			HEXQ A 4 bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}
class RedBPShieldPartVisual : actor {
	Default {
		+NOINTERACTION
		+CLIENTSIDEONLY
		+FLOORCLIP
		
		Radius 8;
		Height 8;
		Scale 0.5;
		RenderStyle "Add";
		Alpha 0.25;
	}	
	States {
		Spawn:
			HEXQ A 4 bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}
class RedBPShieldSpawner5up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 64, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 64, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedBPShieldSpawner4up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 56, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 56, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedBPShieldSpawner3up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedBPShieldHit : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
		Scale 0.5;
		Renderstyle "Add";
	}	
	States {
		Spawn:
			FHIQ A 0 bright;
			FHIQ A 1 bright A_Stop();
			FHIQ A 0 bright A_StartSound ("ForceBarrier/Hit", 0);
			FHIQ BCDEFGH 1 bright;
			stop;
	}
}

// 100% red part ///////////////////////////////////////////////////////////////
class RedPShieldPart : actor {
	Default {
		+SHOOTABLE
		+NOGRAVITY
		+NOTELEPORT
		+NODAMAGE
		+NORADIUSDMG
		+DONTRIP
		+NOBLOODDECALS
		+FLOORCLIP
		+GHOST	//Give projectiles that you wish to pass through the shield THRUGHOST flag
		
		Radius 10;
		Height 16;
		Scale 0.5;
		RenderStyle "None";
		Alpha 0.25;
		Bloodtype "RedPShieldHit";
	}	
	States {
		Spawn:
			HEXR A 4 bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}
class RedPShieldPartVisual : actor {
	Default {
		+NOINTERACTION
		+CLIENTSIDEONLY
		+FLOORCLIP
		
		Radius 8;
		Height 8;
		Scale 0.5;
		RenderStyle "Add";
		Alpha 0.25;
	}	
	States {
		Spawn:
			HEXR A 4 bright;
			stop;
		Death:
			TNT1 A 2;
			stop;
	}
}
class RedPShieldSpawner5up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 64, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 0, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 64, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedPShieldSpawner4up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 56, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 8, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 24, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 40, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 56, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedPShieldSpawner3up : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
			//TNT1 A 0 A_SpawnItemEx ("ShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			stop;
	}
}
class RedPShieldHit : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
		Scale 0.5;
		Renderstyle "Add";
	}	
	States {
		Spawn:
			FHIR A 0 bright;
			FHIR A 1 bright A_Stop();
			FHIR A 0 bright A_StartSound ("ForceBarrier/Hit", 0);
			FHIR BCDEFGH 1 bright;
			stop;
	}
}

class ActiveShield : actor {

	int actShieldCount;
	
	Default {
		-SOLID
		-SHOOTABLE
		
		Tag "$T_DEPLSHIELD";
		scale 0.95;
		radius 12;
		height 27;
	}	
	States {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 A_StartSound ("ForceBarrier/On", 0);
			DUMM A 26;
			DUMM E 3;
			DUMM D 3;
			DUMM C 3;
			goto See;
		See:
			DUMM B 1;
			TNT1 A 0 A_StartSound ("ForceBarrier/Loop", 0);
			TNT1 A 0 A_SpawnItemEx ("ShieldSpawner2");
			DUMM B 2;
			TNT1 A 0 {
				self.actShieldCount++;
			}
			TNT1 A 0 {
				if(self.actShieldCount == 100) {return ResolveState("See2");}
				return resolveState(null);
			}
			Loop;
		See2:
			DUMM C 1;
			TNT1 A 0 A_StartSound ("ForceBarrier/Loop", 0);
			TNT1 A 0 A_SpawnItemEx ("RedAShieldSpawner2");
			DUMM C 2;
			TNT1 A 0 {
				self.actShieldCount++;
			}
			TNT1 A 0 {
				if(self.actShieldCount == 200) {return ResolveState("See3");}
				return resolveState(null);
			}
			Loop;
		See3:
			DUMM D 1;
			TNT1 A 0 A_StartSound ("ForceBarrier/Loop", 0);
			TNT1 A 0 A_SpawnItemEx ("RedBShieldSpawner2");
			DUMM D 2;
			TNT1 A 0 {
				self.actShieldCount++;
			}
			TNT1 A 0 {
				if(self.actShieldCount == 300) {return ResolveState("See4");}
				return resolveState(null);
			}
			Loop;
		See4:
			DUMM E 1;
			TNT1 A 0 A_StartSound ("ForceBarrier/Loop", 0);
			TNT1 A 0 A_SpawnItemEx ("RedShieldSpawner2");
			DUMM E 2;
			TNT1 A 0 {
				self.actShieldCount++;
			}
			TNT1 A 0 {
				if(self.actShieldCount == 400) {return ResolveState("Death");}
				return resolveState(null);
			}
			Loop;
		Death:
			DESP A 0 A_StartSound ("ForceBarrier/Off", 0);
			DUMM A 70;
			DUMM A 3 A_FadeOut (0.05);
			TNT1 A 0 {
				self.actShieldCount = 0;
			}
			goto Death+2;
	}
}
class ShieldSpawner2 : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("PShieldSpawner5up", 8, 0, 0);
			TNT1 A 0 A_SpawnItemEx ("PShieldSpawner4up", 8, 24, 0);
			TNT1 A 0 A_SpawnItemEx ("PShieldSpawner4up", 8, -24, 0);
			TNT1 A 0 A_SpawnItemEx ("PShieldSpawner3up", 8, 48, 0);
			TNT1 A 0 A_SpawnItemEx ("PShieldSpawner3up", 8, -48, 0);
			stop;
	}
}
class RedShieldSpawner2 : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedPShieldSpawner5up", 8, 0, 0);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldSpawner4up", 8, 24, 0);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldSpawner4up", 8, -24, 0);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldSpawner3up", 8, 48, 0);
			TNT1 A 0 A_SpawnItemEx ("RedPShieldSpawner3up", 8, -48, 0);
			stop;
	}
}
class RedAShieldSpawner2 : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldSpawner5up", 8, 0, 0);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldSpawner4up", 8, 24, 0);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldSpawner4up", 8, -24, 0);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldSpawner3up", 8, 48, 0);
			TNT1 A 0 A_SpawnItemEx ("RedAPShieldSpawner3up", 8, -48, 0);
			stop;
	}
} 
class RedBShieldSpawner2 : actor {
	Default {
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
	}	
	States {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldSpawner5up", 8, 0, 0);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldSpawner4up", 8, 24, 0);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldSpawner4up", 8, -24, 0);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldSpawner3up", 8, 48, 0);
			TNT1 A 0 A_SpawnItemEx ("RedBPShieldSpawner3up", 8, -48, 0);
			stop;
	}
}
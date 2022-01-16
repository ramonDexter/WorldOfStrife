class HayRoll : Actor
{
	Default
	{
	//$Category "Decorations/neoworm"
	//$Title "Hay rolled"
	Radius 20;
	Height 50;
	+SOLID;
	}
	States
	{
		Spawn:
		 DUMM A -1;
		 Stop;
	}
}

class HayCube : Actor
{
	Default
	{
	//$Category "Decorations/neoworm"
	//$Title "Hay cube"
	Radius 20;
	Height 32;
	+SOLID;
	+ACTLIKEBRIDGE;
	}
	States
	{
		Spawn:
		 DUMM A -1;
		 Stop;
	}
}

// by NeoWorm
class Cart01 : Actor
{
	Default
	{
    Radius 32;
    Height 48;
	Mass 800;
	+SOLID;
	//Health 600;
	//$Category "Decorations/neoworm"
	//$Title "Cart square 64"
	}

    States
    {
  Spawn:
		 DUMM A -1;
    Stop;
    }
}

// by NeoWorm
class Cart02 : Actor
{
	Default
	{
    Radius 32;
    Height 48;
	Mass 800;
	//Health 600;
	+SOLID;
	//$Category "Decorations/neoworm"
	//$Title "Cart square 64 alternative
	}

    States
    {
  Spawn:
		 DUMM A -1;
    Stop;
    }
}

// by NeoWorm
class Cart03 : Actor
{
	Default
	{
    Radius 32;
    Height 96;
	Mass 800;
	+SOLID;
	//Health 900;
	//$Category "Decorations/neoworm"
	//$Title "Gypsy Cart"
	}

    States
    {
  Spawn:
		 DUMM A -1;
    Stop;
    }
}

class Table01 : Actor
{
	Default
	{
    Radius 32;
    Height 32;
	Mass 400;
	Friction 0.8;
	//Health 120;
    +SOLID
	+PUSHABLE
	+DROPOFF
	+SLIDESONWALLS
	+CANPASS
	+ACTLIKEBRIDGE
	+FLOORCLIP;
	+SHOOTABLE;
	+NOBLOOD;
	PushFactor 0.2;
	//$Category "Decorations/neoworm"
		//$Title "Table square 64"
	}

    States
    {
  Spawn:
		 DUMM A -1;
    Stop;
    }
}

class Table03 : Table01
{
	Default
	{
    Radius 32;
    Height 36;
	Mass 800;
	//Health 600;
	//$Category "Decorations/neoworm"
	//$Title "Table square 64 2"
	}

    States
    {
  Spawn:
		 DUMM A -1;
    Stop;
  Death:
    }
}

// by NeoWorm
// textures by Raven software
class Box01 : Actor
{
	Default
	{
    Radius 32;
    Height 64;
	Mass 1000;
	Friction 0.8;
	//Health 200;
    +SOLID
	+PUSHABLE
	+DROPOFF
	+SLIDESONWALLS
	+CANPASS
	+ACTLIKEBRIDGE
	+FLOORCLIP;
	+SHOOTABLE;
	+NOBLOOD;
	PushFactor 0.1;
	//$Category "Decorations/neoworm"
		//$Title "Box big 1"
	}
	
    States
    {
    Spawn:
		 DUMM A -1;
    Stop;/*
	Death:
    BOX1 A 0 A_Burst("WoodenBit");
	Stop;*/
    }
}

class Box02 : Box01
{
	Default
	{
		//$Category "Boxes"
		//$Title "Box big 2"
	}
	States
    {
    Spawn:
		 DUMM A -1;
    Stop;
    }
}

class Box03 : Box01
{
	Default
	{
    Radius 32;
    Height 32;
	Mass 500;
	Friction 0.8;
	Health 160;
	//$Category "Decorations/neoworm"
		//$Title "Box low"
	}
	
    States
    {
    Spawn:
		 DUMM A -1;
    Stop;
    }
}

class Box04 : Box01
{
	Default
	{
    Radius 16;
    Height 64;
	Mass 400;
	Friction 0.8;
	Health 120;
	//$Category "Decorations/neoworm"
		//$Title "Box small high"
	}
	
    States
    {
    Spawn:
		 DUMM A -1;
    Stop;
    }
}

class Box05 : Box01
{
	Default
	{
    Radius 16;
    Height 32;
	Mass 300;
	Friction 0.8;
	Health 100;
	//$Category "Decorations/neoworm"
		//$Title "Box small"
	}
	
    States
    {
    Spawn:
		 DUMM A -1;
    Stop;
    }
}

// by NeoWorm
// needs destructability
class Sack01 : Actor
{
	Default
	{
	Radius 18;
	Height 12;
	+SOLID;
	//$Category "Decorations/neoworm"
	//$Title "Sack 01"
	}
	States
	{
		Spawn:
			SACK A -1;
			Stop;
	}
}

class Sack02 : Sack01
{
	Default
	{
	Radius 18;
	Height 24;
	//$Category "Decorations/neoworm"
	//$Title "Sack 02"
	}
	States
	{
		Spawn:
			SACK B -1;
			Stop;
	}
}
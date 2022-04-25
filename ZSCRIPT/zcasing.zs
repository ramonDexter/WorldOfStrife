class ZCasing : Actor {
	string spriteName;
	property SpriteName : spriteName;
	
    Default {
        Height 4;
        Radius 2;

        BounceType "Doom";
        BounceFactor 0.5;
        WallBounceFactor 0.5;
		
		ZCasing.SpriteName "CASA";

        +Missile
        +Dropoff
        +NoBlockMap
        +MoveWithSector
        +ThruActors
    }
	
	States {
		Dummy:
		TNT1 A 0;
		Stop;
		
		Spawn:
		CASA A 1 nodelay {
			//sprite = GetSpriteIndex(spriteName);
			//frame = 0;
			//A_setTics(1);
			A_SetRoll((vel.x,vel.y,vel.z).Length() * -50,SPF_INTERPOLATE);			
		}
		Loop;
		
		Death:
        CASA A -1 {
			//sprite = GetSpriteIndex(spriteName);
			//frame = 0;
			//A_setTics(-1);
			//console.printf("%f, %f",roll,roll % 360);
			if(roll % 360 < 180)
			{
				bXFLIP = true;
			}
			A_SetRoll(0);
		}
        Stop;
	}
}

class ZCasingKiller : EventHandler {
    Array<ZCasing> casings;
    int back;

    override void WorldThingSpawned(WorldEvent e) {
        if (!ZCasing(e.thing)) return;

        //int maxCasings = CVar.FindCVar('zwl_maxcasings').GetInt();
		int maxCasings = zwl_maxcasings;
        if (casings.Size() <= back) {
            casings.Push(ZCasing(e.thing));
        }
        else {
            if (casings[back])
                casings[back].Destroy();

            casings[back] = ZCasing(e.thing);
        }
        back = (back + 1) % maxCasings;
    }

    override void WorldTick() {
         //int maxCasings = CVar.FindCVar('zwl_maxcasings').GetInt();
		int maxCasings = zwl_maxcasings;
        if (casings.Size() > maxCasings) {
            Array<ZCasing> newCasings;

            int excess = casings.Size() - maxCasings;

            for (int i = 0; i < casings.Size(); ++i) {
                if (i < excess)
                    casings[back].Destroy();
                else
                    newCasings.Push(casings[back]);

                // Back is just a convenient counter; it isn't being used as the back of the queue, here
                back = (back + 1) % casings.Size();
            }
            back = 0;
            casings.Move(newCasings);
        }
    }
}
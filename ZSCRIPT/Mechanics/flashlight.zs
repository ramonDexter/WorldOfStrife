/*
Steve's Flashlight Mod.

This mod uses the new spotlight actors in GZDoom.

Requirements:

    Needs a release from at least 2018-02-10.

Setup:

    Assign a key to toggle the flashlight in your controls menu right at the bottom of "customise controls".
    Under options, you can select Flashlight and customise it. Options take affect next time it switches on.


Known Issues:

    There is some jitter in the changing of location and orientation of the spotlight. Using the target pointer of lights doesn't solve the jitter and is not suitable anyway as the light should emit from the actor's "shoulder". I'm not sure this will ever be fixed or can even be fixed given the way ZDoom updates actors. You can stop it right now by turning off rendering interpolation off but then you only get 35 FPS. Suggestions very welcome.
    
    
License:

    Unlicense. (That means do what you want. No credit needed.)

//------------------------------------------------------------------------------
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
//------------------------------------------------------------------------------
*/
class Util {

    play static void setupFlashlight (int playerID, int flashID) {
        
        //PlayerPawn act = PlayerPawn(ActorIterator.Create(playerID).Next());
		PlayerPawn act = PlayerPawn(Level.CreateActorIterator(playerID).Next());
        
        if (act) {
        
            ActorHeadLight light = ActorHeadLight(Actor.Spawn("ActorHeadLight"));
        
            light.ChangeTid(flashID);

            light.toFollow = act;
           
            light.activate(null);
            
            Util.LogDebug("Light created and 'attached'");
            
        }
    
    }
    
    static void LogDebug (String text) {
    
        if (CVar.GetCvar("debug")) {        
            Console.printf("[ZScript]  "..text);
        }
    
    }
    
    static int round (double num) {
    
        int result = (num - floor(num) > 0.5) ? ceil(num) : floor(num);
        return result;
    
    }
    

}

class ActorHeadLight : Spotlight {

    enum ELocation
	{
		HELMET = 0,
		RIGHT_SHOULDER = 1,
		LEFT_SHOULDER = 2,
        CAMERA = 3
	};

    PlayerPawn toFollow;

    Vector3 offset;
    
    Vector3 finalOffset;
    
    double zBump; // z offset for locations that are not CAMERA
    
    double angleDiff;    
    double turnAnglePerTic;
    bool ready;
    bool on;
    
    ELocation location;
    
    void updateFromCvars () {
    
        Color c = CVar.FindCVar("flashlight_color").GetString();
    
        args[0] = c.r;
        args[1] = c.g;
        args[2] = c.b;    
        args[3] = CVar.FindCVar("flashlight_intensity").GetInt();
        
        self.SpotInnerAngle = CVar.FindCVar("flashlight_inner").GetFloat();        
        self.SpotOuterAngle = CVar.FindCVar("flashlight_outer").GetFloat();
        
        self.location = CVar.FindCVar("flashlight_location").GetInt();       
       
        
        Util.LogDebug("Light loc offset: "..self.offset);
        
        
                      
    }
    
    
    override void Activate(Actor activator) {
        
        updateFromCvars();
        on = true;
        super.Activate(activator);        

    }
    
    
    override void DeActivate(Actor activator) {
    
        on = false;
        super.DeActivate(activator);
    
    }
        
    
    override void Tick() {
    
        if (ready && on) {

            switch (location) {
            
                case HELMET:
                    offset = (0, 0, toFollow.player.viewheight + zBump);
                    break;
                    
                case RIGHT_SHOULDER:
                    offset = (toFollow.radius, 0, toFollow.player.viewheight + zBump);
                    break;
                    
                case LEFT_SHOULDER:
                    offset = (toFollow.radius * -1, 0, toFollow.player.viewheight + zBump);
                    break;
                    
                case CAMERA:
                    offset = (0, 0, toFollow.ViewHeight);
                    break;
                    
                default:
                    offset = (0, 0, 0);
            
            }
                         
            A_SetAngle(toFollow.angle, 0);
            
            Vector2 finalOffset2D = RotateVector ((offset.x, offset.y), toFollow.angle - 90.0); 
                        
            finalOffset = (finalOffset2D.x, finalOffset2D.y, offset.z);
            
            A_SetPitch(toFollow.pitch, SPF_INTERPOLATE);
            
            SetOrigin(self.toFollow.pos + finalOffset, true);
    
        } else if (on && self.toFollow) {

            ready = true;
            
            zBump = (toFollow.height - toFollow.viewheight) / 2;
            
            Util.LogDebug('zBump assigned: '..zBump);
        
        }
        
        Super.Tick();    
             
    }
    
}




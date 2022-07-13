///////////////////////////////////////////////////////////////////////////////////////
// FOOTSTEPS //////////////////////////////////////////////////////////////////////////
// credits: Da_Zombie_Killer, vsonnier ////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class Footsteps : Actor {
    //the player footsteps are attached to.
    PlayerPawn toFollow;

    array<string> fstep_sounds;
    array<int> fstep_textures;
    string fstep_default_sound;
    
    //VSO: only needed for debug.
    array<string> fstep_textures_names_debug;
    
    int next_update_tics_countdown;

    //attach PlayerPawn, load the texture/sound associated tables.
    void Init( PlayerPawn attached_player) 	{
        next_update_tics_countdown = -1;
        self.toFollow = attached_player;
        
        //Read SOUNDINFO and LANGUAGE to map textures on sounds.
        //only add to (fstep_sounds;fstep_textures) if the texture exist.
        array<String> sSTEP_FLATS_List; 
        
        StringTable.Localize("$STEP_FLATS").Split(sSTEP_FLATS_List, ":");
        //iterate over the list of flat names, and retreive  
        for (int i = 0; i < sSTEP_FLATS_List.Size(); i++) {
            
            String singleFLAT_Sound = StringTable.Localize(String.Format("$STEP_%s", sSTEP_FLATS_List[i]));
            
            if (singleFLAT_Sound.Length() != 0) {
                //check if the texture exists.
                textureid  tx_id = TexMan.CheckForTexture( sSTEP_FLATS_List[i],TexMan.TYPE_ANY);
                
                if (tx_id.Exists()) {
                    //texture exists, add both in the lists:
                    fstep_sounds.Push(singleFLAT_Sound);
                    fstep_textures.Push(int(tx_id));
                    
                    //also keep tx names, but it is only used for debugging.
                    fstep_textures_names_debug.Push(sSTEP_FLATS_List[i]);
                }
            }
        }
        // add fstep_default:
        fstep_default_sound = StringTable.Localize("$STEP_DEFAULT");
    }

    override void Tick() {  
        next_update_tics_countdown--;
        
        //0) do nothing until next_update_tics_countdown is below 0
        if (next_update_tics_countdown > 0) {
            Super.Tick();
            return;
        }
        
        //1) Update the Footstep actor to follow Player.
        SetOrigin(self.toFollow.pos, true);
        self.floorz = self.toFollow.floorz;
           
        double player_speed2d = sqrt(self.toFollow.vel.x * self.toFollow.vel.x + self.toFollow.vel.y * self.toFollow.vel.y);
        
        //2) Only play footsteps when on ground, and if the player is moving fast enough.
        if ((CVar.GetCvar("fs_enabled").GetInt() > 0) && (player_speed2d > 0.1) && (self.toFollow.pos.z - self.toFollow.floorz <= 0)) {
            
             //trace
             //Console.PrintF("Speed2d = %f",player_speed2d);
             
            //current floopic id for player:
            int player_floor_tx_id = int(self.toFollow.floorpic);
           
            //sound volume is amplified by speed.
            double soundLevel = CVar.GetCvar("fs_volume_mul").GetFloat() * player_speed2d;
                  
            //3) Find the matching index of player_floor_tx_id in fstep_textures and retreive the sound to play matching the texture we are in.
            int foundIndex  = fstep_textures.Find(player_floor_tx_id);
            
            if (foundIndex != fstep_textures.Size()) {
    
                //3-1) play the sound
                S_StartSound(fstep_sounds[foundIndex], CHAN_AUTO, 0, soundLevel);
                //Console.PrintF("Found tx = %s, play snd = %s",fstep_textures_names_debug[foundIndex], fstep_sounds[foundIndex]); 
            }
            else {
            
                //3-2) Play default sound if no match was found
                S_StartSound(fstep_default_sound,  CHAN_AUTO, 0, soundLevel);
                //Console.PrintF("Not found Tx ! , play default snd = %s",fstep_default_sound); 
            }
                          
            //4) Compute the next date at which playing a sound step again.
            //clamp the apparent maximum speed, to limit sound repetition interval.         
            if (player_speed2d > 5.0) {
                player_speed2d = 5.0;
            }
            //fastest sound playing speed is set to roughly 0.3s => 10 ticks ( * fs_delay_mul)
            next_update_tics_countdown = (35.0 - ((25.0 / 5.0) * player_speed2d)) * CVar.GetCvar("fs_delay_mul").GetFloat();
           
        } else {
            // no need to poll for change too often
            next_update_tics_countdown = 2;
        }
        
        Super.Tick();
    }  
    Default {
        +NOBLOCKMAP
        Tag "footsteps";
        radius 4;
        height 2;
    }
}
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
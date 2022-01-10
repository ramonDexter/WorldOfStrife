Class wosTargeter : wosPickup replaces Targeter
{
	int charge;
	int depletetimer;
	bool inuse;
	bool targmode;
	Default
	{
		Inventory.MaxAmount 1;
		Tag "Targeter";
		Inventory.Icon "I_TARG";
		Inventory.PickupMessage "Picked up a targeter.";
		Mass TargeterWeight;
	}
	Override void Tick()
	{
		Super.Tick();
		If(owner!=null&&owner.health<1){inuse=0;}
		If(inuse==1)
		{
			If(targmode==1)
			{
				If(charge>=100){UseInventory(self);}
				Else If(depletetimer>=42){charge++; depletetimer=0;}
				Else{depletetimer++;}
				owner.GiveInventory(" wosPowerLightAmp",1);
				owner.TakeInventory(" wosPowerTargeter",1);
			}
			Else
			{
				If(charge>=100){UseInventory(self);}
				Else If(depletetimer>=56){charge++; depletetimer=0;}
				Else{depletetimer++;}
				owner.GiveInventory(" wosPowerTargeter",1);
				owner.TakeInventory(" wosPowerLightAmp",1);
			}
		}
		Else
		{
			If(owner!=null)
			{
				owner.TakeInventory(" wosPowerTargeter",1);
				owner.TakeInventory(" wosPowerLightAmp",1);
			}
		}
		If(charge>=100){A_SetTranslation("EnergyEmpty");}Else{A_SetTranslation("");}
		If(targmode==1){self.Icon=texman.CheckForTexture("I_TAR2",texman.type_any); self.Frame=1;}
		Else{self.Icon=texman.CheckForTexture("I_TARG",texman.type_any); self.Frame=0;}
	}
	Override void DoEffect()
	{
		Super.DoEffect();
		let pawn = binderPlayer(owner);
		double finalweight = 100 - self.charge;
		pawn.encumbrance+=(int)(Ceil(finalweight/10));
	}
	States
	{
	Spawn:
		TARG A -1;
		Stop;
	Pickup:
		TNT1 A 0 A_RailWait();
		Stop;
	Use:
		//TNT1 A 0 A_JumpIfInventory("LFTemplarScreen",1,"UseTemplar");
		TNT1 A 0 A_Overlay(2000,"NightVisionOverlay");
		TNT1 A 0 A_JumpIf(GetPlayerInput(MODINPUT_BUTTONS)&BT_USE,"UseCheck");
		TNT1 A 0 A_JumpIf(GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED,"UseReload");
		TNT1 A 0 A_JumpIf(GetPlayerInput(MODINPUT_BUTTONS)&BT_ZOOM,"UseSwitch");
		TNT1 A 0 A_StartSound("weapons/reload",CHAN_ITEM);
		TNT1 A 0 A_JumpIf(Invoker.inuse==1,"UseEnd");
		TNT1 A 0 A_JumpIf(Invoker.charge>=100,"UseNot");
		TNT1 A 0 {Invoker.inuse=1; Invoker.bUNDROPPABLE=1; A_SetBlend(color(0,0,0),1.0,18);}
		Fail;
	UseEnd:
		TNT1 A 0 {Invoker.inuse=0; Invoker.bUNDROPPABLE=0; A_SetBlend(color(0,0,0),1.0,18);}
		Fail;
	UseCheck:
		TNT1 A 0
		{
			int chargeleft = 100 - Invoker.charge;
			A_Log(String.Format("%i%s", chargeleft, "% charge left"));
		}
		Fail;
	UseNot:
		TNT1 A 0 A_Log("The batteries are used up");
		Fail;
	UseTemplar:
		TNT1 A 0 A_Log("You can't use this now");
		Fail;
	UseReload:
		TNT1 A 0 A_JumpIf(CountInv("EnergyPod")==0||Invoker.charge==0,"UseReloadNot");
		TNT1 A 0
		{
			double finalload = Invoker.charge;
			If((int)(Ceil(finalload/10))>CountInv("EnergyPod")){finalload=CountInv("EnergyPod")*10;}
			TakeInventory("EnergyPod",(int)(Ceil(finalload/10)));
			Invoker.charge-=(int)(finalload);
			A_StartSound("weapons/chamber",CHAN_ITEM);
		}
		Fail;
	UseReloadNot:
		TNT1 A 0 A_Log("Can't reload batteries");
		Fail;
	UseSwitch:
		TNT1 A 0
		{
			If(Invoker.inuse==1){A_SetBlend(color(0,0,0),1.0,18);}
			A_StartSound("weapons/reload",CHAN_ITEM);
			If(Invoker.targmode==1){Invoker.targmode=0;}
			Else{Invoker.targmode=1;}
		}
		Fail;
	NightVisionOverlay:
		TNT1 A 0 A_JumpIf(Invoker.targmode==1&&Invoker.inuse==1,2);
		TNT1 A 1;
		Loop;
		NVSC A 1 {A_OverlayFlags(2000,PSPF_RENDERSTYLE,true); A_OverlayRenderStyle(2000,STYLE_Fuzzy);}
		Loop;
	}
}
Class wosPowerLightAmp : PowerLightAmp
{
	Default
	{
		Powerup.Duration 0x7FFFFFFF;
		+INVENTORY.HUBPOWER;
	}
}
Class wosPowerTargeter : PowerTargeter
{
	Array<Actor> ShotList;
	Default
	{
		Powerup.Duration 0x7FFFFFFF;
		+INVENTORY.HUBPOWER;
	}
	Override void DoEffect()
	{
		Super.DoEffect();
		FLineTraceData h;
		//FTranslatedLineTarget t;
		For(int i = 0; i < 60; i++)
		{
			double an = owner.angle - 30 + 1*i;
			For(int p = 0; p < 60; p++)
			{
				double pi = owner.pitch - 30 + 1*p;
				int hdif = 10;
				If(owner.player.crouchoffset!=0){hdif=5;}
				owner.LineTrace(an,1024,pi,offsetz: owner.height-hdif,data: h);
				//owner.AimLineAttack(an,1024,t,32); //t.linetarget
				If(h.HitActor!=null)
				{
					If(h.HitActor.bISMONSTER==1&&h.HitActor.bSPECTRAL==0)
					{
						If(ShotList.Find(h.HitActor) == ShotList.Size())
						{
							bool spawn1; Actor spawn2;
							[spawn1, spawn2] = h.HitActor.A_SpawnItemEx("LFTargeterHighlight",-1,0,0,0,0,0,an,SXF_TRANSFERSPRITEFRAME|SXF_ABSOLUTEANGLE);
							spawn2.angle=h.HitActor.angle;
							ShotList.Push(h.HitActor);
						}
					}
				}
			}
		}
		ShotList.Clear();
	}
}
Class wosTargeterHighlight : Actor
{
	Default
	{
		+NOBLOCKMAP; +NOGRAVITY;
		Translation "0:255=224:224";
		RenderStyle "Translucent";
		Alpha 0.5;
	}
	States
	{
	Spawn:
		#### # 2 NoDelay Bright;
		Stop;
	}
}
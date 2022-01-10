//version "4.3"
/*
credits: Boondorl
*/
class CustomDOT : Inventory abstract
{
	private Array<int> ticTimers;
	private int effectTimer;
	private int procRate; // Calculated via number of procs
	private int baseDuration;
	
	int duration;
	int numberOfProcs;
	string stackType;
	string damageApplication;
	int effectRate;
	class<Actor> effectActor;
	
	property Duration : duration;
	property NumberOfProcs : numberOfProcs;
	property StackType : stackType;
	property DamageApplication : damageApplication;
	property EffectRate : effectRate;
	property EffectActor : effectActor;
	
	Default
	{
		CustomDOT.Duration 105;
		CustomDOT.NumberOfProcs 3;
		CustomDOT.StackType "Stackable";
		CustomDOT.DamageApplication "Delayed";
		Inventory.MaxAmount 5;
		Damage 5;
		
		+NODAMAGETHRUST
		+NOSECTOR
		+NOBLOCKMAP
		+ICESHATTER
		+INVENTORY.UNDROPPABLE
	}
	
	override void Tick()
	{
		if (!owner || owner.health <= 0 || duration <= 0 || !ticTimers.Size())
			Destroy();
	}
	
	override void DoEffect()
	{
		if (!owner || IsFrozen())
			return;
		
		Effect();
		if (bDestroyed)
			return;
		
		if (effectRate > 0 && effectActor && !(effectTimer++ % effectRate))
		{
			double rad = owner.radius * sqrt(frandom[DOTEffect](0,1));
			double theta = frandom[DOTEffect](0,360);
			Vector3 offset = (rad*cos(theta), rad*sin(theta), frandom[DOTEffect](0, owner.height) - owner.floorclip);
			
			let effect = Spawn(effectActor, owner.Vec3Offset(offset.x, offset.y, offset.z), ALLOW_REPLACE);
			if (effect)
				effect.tracer = owner;
		}
		
		if (procRate <= 0)
			return;
		
		for (uint i = 0; i < ticTimers.Size(); ++i)
		{
			bool doDamage;
			if (damageApplication ~== "Delayed")
				doDamage = !(++ticTimers[i] % procRate);
			else
				doDamage = !(ticTimers[i]++ % procRate);
			
			if (!doDamage)
				continue;
					
			int realDamage = GetMissileDamage(0, random[DOTDamage](1,3));
			int newdam = owner.DamageMobj(self, owner.target, realDamage, damageType, bPoisonAlways ? DMG_FOILINVUL : 0);
			OnProc(newdam);
			if (bDestroyed)
				return;
					
			if (owner.health <= 0)
				return;
			else if (newdam > 0)
			{
				if (owner.HowlSound)
					owner.A_StartSound(owner.HowlSound, CHAN_VOICE);
				else
					owner.A_StartSound(owner.PainSound, CHAN_VOICE);
			}
			
			if (ticTimers[i] >= duration)
				ticTimers.Delete(i--);
		}
	}
	
	virtual void Effect() {}
	
	virtual void OnProc(int dmg) {}
	
	void A_SetMaxStacks(int amount, bool resize = false)
	{
		if (amount < 1)
			amount = 1;
		
		MaxAmount = amount;
		
		if (resize && ticTimers.Size() > MaxAmount)
		{
			for (int i = 0; i < ticTimers.Size() - MaxAmount; ++i)
				ticTimers.Delete(0);
		}
	}
	
	void A_SetDuration(int dur, bool changeProcs = false)
	{
		if (dur < 0)
			dur = 0;
		
		baseDuration = duration = dur;
		
		if (!changeProcs)
			return;
		
		if (damageApplication ~== "Delayed")
			procRate = floor(duration / max(1, numberOfProcs));
		else
		{
			if (numberOfProcs == 1)
				procRate = duration + 1;
			else
				procRate = floor((duration - 1) / max(1, (numberOfProcs - 1)));
		}
	}
	
	void A_SetStackType(string type)
	{
		stackType = type;
	}
	
	void A_SetEffectRate(int er)
	{
		if (er < 0)
			er = 0;
		
		effectRate = er;
	}
	
	void A_SetEffectActor(class<Actor> effect)
	{
		effectActor = effect;
	}
	
	void Reset()
	{
		ticTimers.Clear();
		ticTimers.Push(0);
	}
	
	override void AttachToOwner(Actor other)
	{
		super.AttachToOwner(other);
		Reset();
	}
	
	override bool HandlePickup(Inventory item)
	{
		if (!item || item.GetClass() != GetClass())
			return false;
		
		if (stackType ~== "Stackable")
		{
			if (ticTimers.Size() < MaxAmount)
				ticTimers.Push(0);
		}
		else if (stackType ~== "Additive")
		{
			if (bAdditivePoisonDamage)
				SetDamage(damage + default.damage);
				
			if (bAdditivePoisonDuration)
				duration += baseDuration;
		}
		else
			Reset();
		
		return true;
	}
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		
		if (duration < 0)
			duration = 0;
		if (effectRate < 0)
			effectRate = 0;
		if (MaxAmount < 1)
			MaxAmount = 1;
		if (numberOfProcs < 1)
			numberOfProcs = 1;
		
		baseDuration = duration;
		
		if (damageApplication ~== "Delayed")
			procRate = floor(duration / max(1, numberOfProcs));
		else
		{
			if (numberOfProcs == 1)
				procRate = duration + 1;
			else
				procRate = floor((duration - 1) / max(1, (numberOfProcs - 1)));
		}
	}
}

class DOTEffect : Actor abstract
{
	private Vector3 baseOfs;
	private Vector3 warpOfs;
	
	deprecated("3.7") private int dotEffectFlags;
	flagdef NoWarp : dotEffectFlags, 0;
	
	Default
	{
		+NOINTERACTION
	}
	
	void A_SetWarp(bool newWarp)
	{
		bNoWarp = newWarp;
	}
	
	Vector3 A_ShiftWarpOffset(Vector3 ofs, bool base = false)
	{
		if (base)
			warpOfs = baseOfs + ofs;
		else
			warpOfs += ofs;
			
		return warpOfs;
	}
	
	Vector2 A_ShiftXYOffset(Vector2 ofs, bool base = false)
	{
		if (base)
			warpOfs.xy = baseOfs.xy + ofs;
		else
			warpOfs.xy += ofs;
			
		return warpOfs.xy;
	}
	
	double A_ShiftZOffset(double ofs, bool base = false)
	{
		if (base)
			warpOfs.z = baseOfs.z + ofs;
		else
			warpOfs.z += ofs;
			
		return warpOfs.z;
	}
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		
		if (tracer)
			baseOfs = warpOfs = tracer.Vec3To(self);
	}
	
	override void Tick()
	{
		super.Tick();
		
		if (bDestroyed || IsFrozen())
			return;
		
		if (!tracer || tracer.health <= 0)
		{
			Destroy();
			return;
		}
		
		Effect();
		if (bDestroyed)
			return;
		
		if (!bNoWarp)
			SetOrigin(tracer.Vec3Offset(warpOfs.x, warpOfs.y, warpOfs.z), true);
	}
	
	virtual void Effect() {}
}

enum EChangePropertyFlags
{
	// AoE
	CPF_INFINITELYTALL = 1,
	CPF_NOLIQUIDS = 1<<1,
	CPF_OVERLAP = 1<<2,
	
	// Projectile
	CPF_DONTSPLASHHITACTOR = 1<<3,
	CPF_HITONCE = 1<<4,
	CPF_INVERT = 1<<5
}

class AoE : Actor abstract
{
	private Array<Actor> inCoolDown;
	private Array<int> coolDownTimers;
	private int effectTimer;
	
	class<Actor> effectActor;
	class<CustomDOT> DOTType;
	int effectRate;
	int coolDown;
	string coolDownType;
	
	property CoolDown : coolDown;
	property CoolDownType : coolDownType;
	property DOTType : DOTType;
	property EffectRate : effectRate;
	property EffectActor : effectActor;
	
	deprecated("3.7") private int aoeFlags;
	flagdef InfinitelyTall : aoeFlags, 0;
	flagdef NoLiquids : aoeFlags, 1;
	flagdef Overlap : aoeFlags, 2;
	
	Default
	{
		AoE.CoolDown 8;
		AoE.CoolDownType "Instance";
		
		+NOGRAVITY
		+NOBLOCKMAP
		+NODAMAGETHRUST
		+NOTELEPORT
		+MOVEWITHSECTOR
		+ICESHATTER
		+AOE.OVERLAP
	}
	
	override void Tick()
	{
		super.Tick();
		
		if (bDestroyed || IsFrozen())
			return;
		
		if (bNoLiquids && waterlevel > 0)
		{
			Destroy();
			return;
		}
		
		Effect();
		if (bDestroyed)
			return;
		
		if (effectRate > 0 && effectActor && !(effectTimer++ % effectRate))
		{
			double rad = radius * sqrt(frandom[AoEEffect](0,1));
			double theta = frandom[AoEEffect](0,360);
			
			Vector2 offset = Vec2Offset(rad*cos(theta), rad*sin(theta));
			double floor = GetZAt(offset.x, offset.y, flags: GZF_ABSOLUTEPOS);
			if (bInfinitelyTall || abs(floor - pos.z) <= height)
				Spawn(effectActor, (offset, floor), ALLOW_REPLACE);
		}
		
		for (uint i = 0; i < coolDownTimers.Size(); ++i)
		{
			if (--coolDownTimers[i] <= 0)
			{
				coolDownTimers.Delete(i);
				inCoolDown.Delete(i--);
			}
		}
		
		if (radius > 0)
		{
			double radSq = radius * radius;
			BlockThingsIterator it = BlockThingsIterator.Create(self);
			Actor mo;
			while (it.Next())
			{
				mo = it.thing;
				if (!mo || (mo == target && !bHitOwner) || !mo.bShootable || !(mo.player || mo.bIsMonster) || (mo.health <= 0 && !mo.bIceCorpse))
					continue;
				
				if (inCoolDown.Find(mo) != inCoolDown.Size())
					continue;
				
				if (!bInfinitelyTall)
				{
					if (abs(mo.floorz - pos.z) > height)
						continue;
					
					if (mo.pos.z > pos.z+height || mo.pos.z+mo.height < pos.z)
						continue;
				}
				
				Vector3 rel = mo.PosRelative(CurSector);
				Vector2 ofs = (mo.radius, mo.radius);
				Vector2 moMin = level.Vec2Offset(rel.xy, -ofs);
				Vector2 moMax = level.Vec2Offset(rel.xy, ofs);
				
				Vector2 nearest;
				nearest.x = max(moMin.x, min(pos.x, moMax.x));
				nearest.y = max(moMin.y, min(pos.y, moMax.y));
							
				Vector2 dist = level.Vec2Diff(nearest, pos.xy);
				if ((dist dot dist) > radSq)
					continue;
				
				if (!CheckSight(mo, SF_IGNOREVISIBILITY|SF_SEEPASTBLOCKEVERYTHING|SF_SEEPASTSHOOTABLELINES))
					continue;
					
				int realDamage = GetMissileDamage(0, random[AoEDamage](1,3));
				int newdam = mo.DamageMobj(self, mo.target, realDamage, damageType);
				mo.A_GiveInventory(DOTType);
				OnHit(mo, newdam);
				if (bDestroyed)
					return;
						
				if (coolDownType ~== "Class")
				{
					ThinkerIterator it = ThinkerIterator.Create(GetClass(), STAT_DEFAULT);
					AoE area;
					while (area = AoE(it.Next()))
					{
						if (!area)
							continue;
								
						area.inCoolDown.Push(mo);
						area.coolDownTimers.Push(area.coolDown);
					}
				}
				else
				{
					inCoolDown.Push(mo);
					coolDownTimers.Push(coolDown);
				}
			}
		}
	}
	
	virtual void Effect() {}
	
	virtual void OnHit(Actor mo, int dmg) {}
	
	void A_ChangeAoEFlags(int flags, bool toggle)
	{
		if (flags & CPF_INFINITELYTALL)
			bInfinitelyTall = toggle;
		if (flags & CPF_NOLIQUIDS)
			bNoLiquids = toggle;
		if (flags & CPF_OVERLAP)
			bOverlap = toggle;
	}
	
	void A_SetCoolDown(int cd)
	{
		if (cd < 0)
			cd = 0;
		
		coolDown = cd;
	}
	
	void A_SetCoolDownType(string type)
	{
		coolDownType = type;
	}
	
	void A_ModifyDOT(class<CustomDOT> newDOT)
	{
		DOTType = newDOT;
	}
	
	void A_SetEffectRate(int er)
	{
		if (er < 0)
			er = 0;
		
		effectRate = 0;
	}
	
	void A_SetEffectActor(class<Actor> effect)
	{
		effectActor = effect;
	}
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		
		if (coolDown < 0)
			coolDown = 0;
		if (effectRate < 0)
			effectRate = 0;
	}
}

// For easy transfer between regular and fast projectiles
mixin class Projectile
{
	private Array<Actor> alreadyHit;
	private Array<Actor> alreadyAppliedDOT;
	private Actor lastHit;
	
	double radiusScale;
	double heightScale;
	double maxRadiusScale;
	double maxHeightScale;
	double radiusScaleFactor;
	double heightScaleFactor;
	
	double maxXScale;
	double maxYScale;
	double xScaleFactor;
	double yScaleFactor;
	
	class<CustomDOT> DOTType;

	property DOTType : DOTType;
	
	property RadiusScale : radiusScale;
	property HeightScale : heightScale;
	property MaxRadiusScale : maxRadiusScale;
	property MaxHeightScale : maxHeightScale;
	property RadiusScaleFactor : radiusScaleFactor;
	property HeightScaleFactor : heightScaleFactor;
	
	property MaxXScale : maxXScale;
	property MaxYScale : maxYScale;
	property XScaleFactor : xScaleFactor;
	property YScaleFactor : yScaleFactor;
	
	deprecated("3.7") private int missileFlags;
	flagdef DontSplashHitActor : missileFlags, 0;
	flagdef HitOnce : missileFlags, 1;
	flagdef Invert : missileFlags, 2;
	
	Actor A_AreaOfEffect(class<AoE> aoe, double step)
	{
		if (!aoe || pos.z > floorz + step)
			return null;
		
		let def = AoE(GetDefaultByType(aoe));
		class<AoE> check = "AoE";
		if (def.bOverlap)
			check = aoe;
		
		ThinkerIterator it = ThinkerIterator.Create(check, STAT_DEFAULT);
		AoE mo;
		while (mo = AoE(it.Next()))
		{
			if (!mo || Distance2DSquared(mo) > (mo.radius+def.radius)**2)
				continue;
			
			if (def.bInfinitelyTall || mo.bInfinitelyTall)
				return null;
				
			double diff = mo.pos.z - floorz;
			if ((diff < 0 && abs(diff) <= mo.height) || diff <= def.height)
				return null;
		}
					
		let newAoE = Spawn(aoe, (pos.x, pos.y, floorz), ALLOW_REPLACE);
		if (newAoE)
			newAoE.target = target;
		
		return newAoE;
	}
	
	int A_Splash(int dmg = -1, int dist = -1, int flags = XF_HURTSOURCE, bool alert = false, int fulldamagedistance = 0, int nails = 0, int naildamage = 10, class<Actor> pufftype = "BulletPuff", name dmgType = 'None', class<CustomDOT> splashDOT = null)
	{
		if (dmg < 0)
		{
			dmg = ExplosionDamage;
			dist = ExplosionRadius;
			flags = !DontHurtShooter;
		}
		else if (dist < 0)
			dist = dmg;
		
		if (dist > 0 && splashDOT)
		{
			BlockThingsIterator it = BlockThingsIterator.Create(self, dist);
			Actor mo;
			while (it.Next())
			{
				mo = it.thing;
				if (!mo || (mo == target && !(flags & XF_HURTSOURCE)) || !mo.bShootable || !(mo.player || mo.bIsMonster) || mo.health <= 0)
					continue;
				
				if (bDontSplashHitActor && lastHit == mo)
					continue;
				
				if (target && !mo.player
					&& ((target.bDontHarmClass && mo.GetClass() == target.GetClass())
					|| (target.bDontHarmSpecies && mo.GetSpecies() == target.GetSpecies())))
				{
					continue;
				}
				
				if (GetRadiusDamage(mo, dmg, dist, fulldamagedistance, bOldRadiusDmg) > 0 && CheckSight(mo, SF_IGNOREVISIBILITY|SF_IGNOREWATERBOUNDARY))
					mo.A_GiveInventory(splashDOT);
			}
		}
		
		bool noDamage;
		Actor last;
		if (lastHit)
		{
			last = lastHit;
			noDamage = lastHit.bNoDamage;
		
			if (bDontSplashHitActor)
				lastHit.bNoDamage = true;
		}
		
		int count = A_Explode(dmg, dist, flags, alert, fulldamagedistance, nails, naildamage, pufftype, dmgType);
		
		if (last)
			last.bNoDamage = noDamage;
		
		return count;
	}

	void ClearHit()
	{
		alreadyHit.Clear();
		alreadyAppliedDOT.Clear();
	}
	
	Actor GetLastHit()
	{
		return lastHit;
	}
	
	void ClearLastHit()
	{
		lastHit = null;
	}
	
	void A_ModifyDOT(class<CustomDOT> newDOT)
	{
		DOTType = newDOT;
	}
	
	void A_ChangeMissileFlags(int flags, bool toggle)
	{
		if (flags & CPF_DONTSPLASHHITACTOR)
			bDontSplashHitActor = toggle;
		if (flags & CPF_HITONCE)
			bHitOnce = toggle;
		if (flags & CPF_INVERT)
			bInvert = toggle;
	}
	
	void A_SetMaxScales(double newMaxRadius = -1, double newMaxHeight = -1, double newMaxXScale = -1, double newMaxYScale = -1)
	{
		if (newMaxRadius >= 0)
			maxRadiusScale = newMaxRadius;
		if (newMaxHeight >= 0)
			maxHeightScale = newMaxHeight;
		if (newMaxXScale >= 0)
			maxXScale = min(4, newMaxXScale);
		if (newMaxYScale >= 0)
			maxYScale = min(4, newMaxYScale);
			
		if (bInvert)
		{	
			if (maxRadiusScale > radiusScale)
				maxRadiusScale = radiusScale;
			if (maxHeightScale > heightScale)
				maxHeightScale = heightScale;
			
			if (maxXScale > scale.x)
				maxXScale = scale.x;
			if (maxYScale > scale.y)
				maxYScale = scale.y;
		}
		else
		{
			if (maxRadiusScale < radiusScale)
				maxRadiusScale = radiusScale;
			if (maxHeightScale < heightScale)
				maxHeightScale = heightScale;
			
			if (maxXScale < scale.x)
				maxXScale = scale.x;
			if (maxYScale < scale.y)
				maxYScale = scale.y;
		}
	}
	
	void A_SetScaleFactors(double newRadiusFactor = -1, double newHeightFactor = -1, double newXScaleFactor = -1, double newYScaleFactor = -1)
	{
		if (newRadiusFactor >= 0)
			radiusScaleFactor = newRadiusFactor;
		if (newHeightFactor >= 0)
			heightScaleFactor = newHeightFactor;
		if (newXScaleFactor >= 0)
			xScaleFactor = newXScaleFactor;
		if (newYScaleFactor >= 0)
			yScaleFactor = newYScaleFactor;
	}
	
	void A_SetScales(double newRadiusScale = -1, double newHeightScale = -1, double newXScale = -1, double newYScale = -1)
	{
		if (newRadiusScale >= 0)
			radiusScale = newRadiusScale;
		if (newHeightScale >= 0)
			heightScale = newHeightScale;
		if (newXScale >= 0)
			scale.x = min(4, newXScale);
		if (newYScale >= 0)
			scale.y = min(4, newYScale);
		
		A_SetSize(default.radius*radiusScale, default.height*heightScale);
	}
	
	virtual void CustomEffect() {}
	
	// This has to be done before anything since fired missiles can be killed immediately after spawning
	override void BeginPlay()
	{
		super.BeginPlay();
		
		if (radiusScale < 0)
			radiusScale = 0;
		if (heightScale < 0)
			heightScale = 0;
		
		A_SetSize(radius*radiusScale, height*heightScale);
	}
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		
		maxXScale = clamp(maxXScale, 0, 4);
		maxYScale = clamp(maxYScale, 0, 4);
		
		if (maxRadiusScale < 0)
			maxRadiusScale = 0;
		if (maxHeightScale < 0)
			maxHeightScale = 0;
		
		if (bInvert)
		{
			if (maxRadiusScale > radiusScale)
				maxRadiusScale = radiusScale;
			if (maxHeightScale > heightScale)
				maxHeightScale = heightScale;
			
			if (maxXScale > scale.x)
				maxXScale = scale.x;
			if (maxYScale > scale.y)
				maxYScale = scale.y;
		}
		else
		{
			if (maxRadiusScale < radiusScale)
				maxRadiusScale = radiusScale;
			if (maxHeightScale < heightScale)
				maxHeightScale = heightScale;
			
			if (maxXScale < scale.x)
				maxXScale = scale.x;
			if (maxYScale < scale.y)
				maxYScale = scale.y;
		}
		
		if (radiusScaleFactor < 0)
			radiusScaleFactor = 0;
		if (heightScaleFactor < 0)
			heightScaleFactor = 0;
		
		if (xScaleFactor < 0)
			xScaleFactor = 0;
		if (yScaleFactor < 0)
			yScaleFactor = 0;
	}
	
	override void Tick()
	{
		super.Tick();
		
		if (bDestroyed || !bMissile || IsFrozen())
			return;
		
		// Different name since this can be used on FastProjectiles
		CustomEffect();
		if (bDestroyed)
			return;
		
		lastHit = null;

		if (bInvert)
		{
			scale.x = max(scale.x - xScaleFactor, maxXScale);
			scale.y = max(scale.y - yScaleFactor, maxYScale);
			radiusScale = max(radiusScale - radiusScaleFactor, maxRadiusScale);
			heightScale = max(heightScale - heightScaleFactor, maxHeightScale);
		}
		else
		{
			scale.x = min(scale.x + xScaleFactor, maxXScale);
			scale.y = min(scale.y + yScaleFactor, maxYScale);
			radiusScale = min(radiusScale + radiusScaleFactor, maxRadiusScale);
			heightScale = min(heightScale + heightScaleFactor, maxHeightScale);
		}
		
		A_SetSize(default.radius*radiusScale, default.height*heightScale);
	}
	
	override int SpecialMissileHit(Actor victim)
	{
		if (alreadyHit.Find(victim) != alreadyHit.Size())
			return 1;
		
		if ((victim.player || victim.bIsMonster) && victim.health > 0 && (victim != target || bHitOwner)
			&& victim.bShootable && (!victim.bSpectral || bSpectral))
		{
			lastHit = victim;
			
			if (alreadyAppliedDOT.Find(victim) == alreadyAppliedDOT.Size())
			{
				victim.A_GiveInventory(DOTType);
				if (bHitOnce)
					alreadyAppliedDOT.Push(victim);
			}
		}
		
		return -1;
	}
	
	override int DoSpecialDamage(Actor target, int damage, name damagetype)
	{
		if (bHitOnce && target == lastHit && alreadyHit.Find(target) == alreadyHit.Size())
			alreadyHit.Push(target);
		
		return super.DoSpecialDamage(target, damage, damagetype);
	}
}

class Missile : Actor abstract
{
	mixin Projectile;
	
	Default
	{
		Projectile;
		Missile.RadiusScale 1;
		Missile.HeightScale 1;
		Missile.MaxRadiusScale 1;
		Missile.MaxHeightScale 1;
		Missile.MaxXScale 1;
		Missile.MaxYScale 1;
		
		+RIPPER
		+ICESHATTER
	}
}

// For people that want to make use of fast projectiles with it
class FastMissile : FastProjectile abstract
{
	mixin Projectile;
	
	Default
	{
		FastMissile.RadiusScale 1;
		FastMissile.HeightScale 1;
		FastMissile.MaxRadiusScale 1;
		FastMissile.MaxHeightScale 1;
		FastMissile.MaxXScale 1;
		FastMissile.MaxYScale 1;
		
		+RIPPER
		+ICESHATTER
	}
}
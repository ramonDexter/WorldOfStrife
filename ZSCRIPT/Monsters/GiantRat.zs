class wosGiantRat : actor {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Giant Rat"
		
		+FLOORCLIP
		
		Tag "$T_GiantRat";
		Health 30;
		Speed 10;
		Radius 20;
		Height 24;
		Mass 50;
		Monster;
		SeeSound "rat/squeek";
		DeathSound "rat/death";
		ActiveSound "rat/active";
		Obituary "$OBI_GiantRat";
		//DropItem "credit";
	}
	
	States {
		Spawn:
			RATS A 10 A_Look();
			Loop;
		See:
			RATS BBCCDDEE 2 A_Chase();
			Loop;
		Melee:
			RATS F 4 A_FaceTarget();
			RATS G 4 A_StartSound ("Rat/Squeek");
			RATS H 4 A_CustomMeleeAttack (2, "Rat/Bite", "none");
			RATS A 8 A_FaceTarget();
			Goto See;
		Death:
			RATS I 3 A_ScreamAndUnblock();
			RATS I 0 A_StartSound ("Rat/Splat");
			RATS JKL 3;
			RATS L -1;
			stop;
		Raise:
			RATS LKJI 3;
			Goto See;
	}
}

//This is the default base describer
class DescriberBase_Default : MWR_DescriberBase
{
	protected string desc_miss_tex;

	protected GramDescObj gdo_text_YouSee;
	protected GramDescObj gdo_null;
	protected GramDescObj gdo_sky;
	protected GramDescObj gdo_miss_tex;
	protected GramDescObj gdo_miss_act;
	protected GramDescObj gdo_loc_tex;
	protected GramDescObj gdo_loc_cei;
	protected GramDescObj gdo_loc_ctr;
	protected GramDescObj gdo_loc_c3d;
	protected GramDescObj gdo_loc_flo;
	protected GramDescObj gdo_loc_ftr;
	protected GramDescObj gdo_loc_f3d;
	protected GramDescObj gdo_loc_wal;
	protected GramDescObj gdo_loc_wtr;
	protected GramDescObj gdo_loc_w3d;
	
	override void InitializeYourself()
	{
		//Initialize - look up values
		desc_miss_tex=MWR_LanguageHandler.LanguageLookupString('DESC_MISS_TEX','[TEXTURE]%t');

		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_NULL',gdo_null,'[NULL]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_SKY',gdo_sky,'[SKY]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_MISS_TEX',gdo_miss_tex,'[TEXTURE]%t');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_MISS_ACT',gdo_miss_act,'[ACTOR]%t');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_TEX',gdo_loc_tex,'[SURFACE]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_CEI',gdo_loc_cei,'[CEILING]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_CTR',gdo_loc_ctr,'[CEILING.TRUE]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_C3D',gdo_loc_c3d,'[CELING.FALSE]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_FLO',gdo_loc_flo,'[FLOOR]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_FTR',gdo_loc_ftr,'[FLOOR.TRUE]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_F3D',gdo_loc_f3d,'[FLOOR.FALSE]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_WAL',gdo_loc_wal,'[WALL]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_WTR',gdo_loc_wtr,'[WALL.TRUE]');
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_LOC_W3D',gdo_loc_w3d,'[WALL.FALSE]');
		
		// Sanity check some values
		if (gdo_text_YouSee.text.IndexOf('%o')<0)
		{
			Console.Printf('[ERROR]MWR_Describer: Bad DESC_TEST_YOUSEE');
			gdo_text_YouSee.text='[YOU_SEE]%o[EOL]';
		}
	}
	
	override bool TryDescribeHitNothing(out GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		MWR_LanguageHandler.SetGdo(TheObject,gdo_null);
		return true;
	}
	override bool TryDescribeHitSky(out GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		MWR_LanguageHandler.SetGdo(TheObject,gdo_sky);
		return true;
	}
	override bool TryDescribeHitCeiling(out GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		if (ltd.Hit3DFloor)
		{
			DescribeTextureCeiling3d(TheObject,ltd.HitTexture);
		} else {
			DescribeTextureCeilingTrue(TheObject,ltd.HitTexture);
		}
		return true;
	}
	override bool TryDescribeHitFloor(out GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		if (ltd.Hit3DFloor)
		{
			DescribeTextureFloor3d(TheObject,ltd.HitTexture);
		} else {
			DescribeTextureFloorTrue(TheObject,ltd.HitTexture);
		}
		return true;
	}
	override bool TryDescribeHitWall(out GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		if (ltd.Hit3DFloor)
		{
			DescribeTextureWall3d(TheObject,ltd.HitTexture);
		} else {
			DescribeTextureWallTrue(TheObject,ltd.HitTexture);
		}
		return true;
	}
	override bool TryDescribeActor(out GramDescObj TheObject, actor a, actor observer, bool examine)
	{
		if (!a){return false;}
		
		string Description='';
		string aTag=a.getTag();
		/*
		if (a is "Inventory" && MWR_LanguageHandler.TryLookup(('DESC_INV_'..aTag),Description)){
			Description=DescribeQuantity(Description,inventory(a).amount);
			MWR_LanguageHandler.TryStringToGramDescObj(TheObject,Description);
		}
		*/
		if (MWR_LanguageHandler.TryLookup(('DESC_ACT_'..aTag),Description))
		{
			if (!MWR_LanguageHandler.TryStringToGramDescObj(TheObject,Description))
			{
				MWR_LanguageHandler.StringToGdoGeneric(TheObject, Description);
			}
		} else {
			MWR_LanguageHandler.SetGdo(TheObject,gdo_miss_act);
			//TheObject.text=TheObject.text..' "'..aTag..'"'; //DEBUG
			TheObject.text.replace('%t',aTag);
		}
		if (a.player)
		{
			switch (a.player.GetGender())
			{
				case 0:
					TheObject.gender=GRMGEN_Masculine;
					break;
				case 1:
					TheObject.gender=GRMGEN_Feminine;
					break;
				case 2:
					TheObject.gender=GRMGEN_Indeterminate;
					break;
				case 3:
					TheObject.gender=GRMGEN_Object;
					break;
			}
		}
		return true;
	}


	//Take a textureId and return a string to use for language lookup
	string TextureId2LookupGeneric(TextureId t){return 'DESC_TEX_'..t;}
	string TextureId2LookupWallGeneric(TextureId t){return 'DESC_WAL_'..t;}
	string TextureId2LookupWallTrue(TextureId t){return 'DESC_WTR_'..t;}
	string TextureId2LookupWall3d(TextureId t){return 'DESC_W3D_'..t;}
	string TextureId2LookupFloorGeneric(TextureId t){return 'DESC_FLO_'..t;}
	string TextureId2LookupFloorTrue(TextureId t){return 'DESC_FTR_'..t;}
	string TextureId2LookupFloor3d(TextureId t){return 'DESC_F3D_'..t;}
	string TextureId2LookupCeilingGeneric(TextureId t){return 'DESC_CEI_'..t;}
	string TextureId2LookupCeilingTrue(TextureId t){return 'DESC_CTR_'..t;}
	string TextureId2LookupCeiling3d(TextureId t){return 'DESC_C3D_'..t;}
	
	//single lookup attempts
	bool TryLookupTextureGeneric(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupGeneric(t),ValueStr);
	}
	bool TryLookupTextureWallGeneric(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupWallGeneric(t),ValueStr);
	}
	bool TryLookupTextureWallTrue(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupWallTrue(t),ValueStr);
	}
	bool TryLookupTextureWall3d(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupWall3d(t),ValueStr);
	}
	bool TryLookupTextureFloorGeneric(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupFloorGeneric(t),ValueStr);
	}
	bool TryLookupTextureFloorTrue(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupFloorTrue(t),ValueStr);
	}
	bool TryLookupTextureFloor3d(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupFloor3d(t),ValueStr);
	}
	bool TryLookupTextureCeilingGeneric(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupCeilingGeneric(t),ValueStr);
	}
	bool TryLookupTextureCeilingTrue(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupCeilingTrue(t),ValueStr);
	}
	bool TryLookupTextureCeiling3d(TextureId t, out string ValueStr){
		return MWR_LanguageHandler.TryLookup(TextureId2LookupCeiling3d(t),ValueStr);
	}

	//what to use when all texture lookups fail
	string DescribeTextureMissingDescription(TextureId t){
		string desctex=desc_miss_tex;
		desctex.replace('%t',''..t);
		return desctex;
	}	

	//lookups with fall-through
	string LookupTextureGeneric(TextureId t){
		string ReturnStr='';
		if (!TryLookupTextureGeneric(t,ReturnStr)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureWallGeneric(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureWallGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureWallTrue(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureWallTrue(t,ReturnStr)||
			TryLookupTextureWallGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureWall3d(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureWall3d(t,ReturnStr)||
			TryLookupTextureWallGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureFloorGeneric(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureFloorGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureFloorTrue(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureFloorTrue(t,ReturnStr)||
			TryLookupTextureFloorGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureFloor3d(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureFloor3d(t,ReturnStr)||
			TryLookupTextureFloorGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureCeilingGeneric(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureCeilingGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureCeilingTrue(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureCeilingTrue(t,ReturnStr)||
			TryLookupTextureCeilingGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}
	string LookupTextureCeiling3d(TextureId t){
		string ReturnStr='';
		if (!(
			TryLookupTextureCeiling3d(t,ReturnStr)||
			TryLookupTextureCeilingGeneric(t,ReturnStr)||
			TryLookupTextureGeneric(t,ReturnStr)
		)){
			ReturnStr=DescribeTextureMissingDescription(t);
		}
		return ReturnStr;
	}

	//These routines build a GDO from a texture based on it's location.
	//They also do th location code '%l' replacement.
	void DescribeTextureGeneric(out GramDescObj DescGdo, TextureId t){
		string DescStr=LookupTextureGeneric(t);
		MWR_LanguageHandler.TryStringToGramDescObj(DescGdo,DescStr);
		MWR_LanguageHandler.TryCombineGdoText(DescGdo,'%l',gdo_loc_tex);
	}
	void DescribeTextureCeiling3d(out GramDescObj DescGdo, TextureId t){
		string DescStr=LookupTextureCeiling3d(t);
		MWR_LanguageHandler.TryStringToGramDescObj(DescGdo,DescStr);
		MWR_LanguageHandler.TryCombineGdoText(DescGdo,'%l',gdo_loc_c3d);
	}
	void DescribeTextureCeilingTrue(out GramDescObj DescGdo, TextureId t){
		string DescStr=LookupTextureCeilingTrue(t);
		MWR_LanguageHandler.TryStringToGramDescObj(DescGdo,DescStr);
		MWR_LanguageHandler.TryCombineGdoText(DescGdo,'%l',gdo_loc_ctr);
	}
	void DescribeTextureFloor3d(out GramDescObj DescGdo, TextureId t){
		string DescStr=LookupTextureFloor3d(t);
		MWR_LanguageHandler.TryStringToGramDescObj(DescGdo,DescStr);
		MWR_LanguageHandler.TryCombineGdoText(DescGdo,'%l',gdo_loc_f3d);
	}
	void DescribeTextureFloorTrue(out GramDescObj DescGdo, TextureId t){
		string DescStr=LookupTextureFloorTrue(t);
		MWR_LanguageHandler.TryStringToGramDescObj(DescGdo,DescStr);
		MWR_LanguageHandler.TryCombineGdoText(DescGdo,'%l',gdo_loc_ftr);
	}
	void DescribeTextureWall3d(out GramDescObj DescGdo, TextureId t){
		string DescStr=LookupTextureWall3d(t);
		MWR_LanguageHandler.TryStringToGramDescObj(DescGdo,DescStr);
		MWR_LanguageHandler.TryCombineGdoText(DescGdo,'%l',gdo_loc_w3d);
	}
	void DescribeTextureWallTrue(out GramDescObj DescGdo, TextureId t){
		string DescStr=LookupTextureWallTrue(t);
		MWR_LanguageHandler.TryStringToGramDescObj(DescGdo,DescStr);
		MWR_LanguageHandler.TryCombineGdoText(DescGdo,'%l',gdo_loc_wtr);
	}

}

//This is the inventory describer. It will try to describe inventory items, and let everything else fallthrough to the default describer.
class DescriberBase_Inventory : MWR_DescriberBase
{
	override bool TryDescribeActor(out GramDescObj TheObject, actor a, actor observer, bool examine)
	{
		if (!a || !(a is "Inventory"))
		{
			return false;
		}
		
		string Description='';
		string aTag=a.getTag();
		
		if (MWR_LanguageHandler.TryLookup(('DESC_INV_'..aTag),Description))
		{
			if (MWR_LanguageHandler.TryStringToGramDescObjQuantity(TheObject,Description,inventory(a).amount))
			{
				return true;
			}
		}
		return false;
	}

}

//This is a name provider. It uses the same structure as an AddOn provider. The difference is that it only returns a name in the string and no other sentence structure.
class DescriberAddon_Name : MWR_DescriberAddon
{
	override bool TryDescribeActor(out string description, in GramDescObj TheObject, actor a, actor observer, bool examine)
	{
		string aclass=a.getclassname();
		string atag=a.gettag();
		string aname=a.getcharactername();
		description=atag;
		if (atag!=aname){description=aname;}
		//console.printf('class,tag,name: '..aclass..', '..atag..', '..aname);//DEBUG
		if (a.player){
			description=a.player.GetUserName();
			return true;
		}
		return atag!=description;
	}
}

//This is the default addon provider.
class DescriberAddon_Default : MWR_DescriberAddOn{
	MWR_DescriberPercentage dpHealth;
	
	override void InitializeYourself(){
		super.InitializeYourself();
		dpHealth=new('MWR_DescriberPercentage');
		dpHealth.Initialize('Health');
	}
	override void PrintDebugStuff(){
		super.PrintDebugStuff();
		dpHealth.PrintRefIndex();
	}
	
	override bool TryDescribeHitFloor(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		clear();
		
		DescribeFloorDamage(TheObject,ltd);
		
		description=BuildText(TheObject);
		return description.length()>0; //bool
	}
	override bool TryDescribeHitWall(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		clear();
		
		DescribeWallActivators(TheObject,ltd);

		description=BuildText(TheObject);
		return description.length()>0; //bool
	}
	override bool TryDescribeActor(out string description, in GramDescObj TheObject, actor a, actor observer, bool examine)
	{
		clear();
		
		//DescribeActorName(TheObject, a);
		DescribeActorFriendliness(observer, TheObject, a);
		DescribeActorHealth(TheObject, a);
		DescribeActorTarget(observer, TheObject, a);
		
		description=BuildText(TheObject);
		return description.length()>0; //bool
	}
	
	//actor describers
	void DescribeActorName(in GramDescObj TheObject, actor a){
		string ThisDescriptionAddition;
		if (a.health>0){
			ThisDescriptionAddition=MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_NAME',TheObject,'[NAME]%n');
		} else {
			ThisDescriptionAddition=MWR_LanguageHandler.LookupGrammaticMatchCategory('DESC_TEXT_NAME','DEAD',TheObject,'[DEADNAME]%n');
		}
		if (a.player){
			ThisDescriptionAddition.replace('%n',a.player.GetUserName());
			AddPreText(ThisDescriptionAddition);
		}
	}
	void DescribeActorFriendliness(actor observer, in GramDescObj TheObject, actor a){
		string adjective;

		if (a.isFriend(observer)){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADJ_FRIEND',TheObject,'[FRIEND]');
			if (a.health>0){
				AddAdjLooks(adjective);
			} else {
				AddAdjWas(adjective);
			}
		}		
		
		if (a.isHostile(observer) && (a.bIsMonster || a.player)){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADJ_HOSTILE',TheObject,'[HOSTILE]');
			if (a.health>0){
				AddAdjLooks(adjective);
			} else {
				AddAdjWas(adjective);
			}
		}
		
	}
	void DescribeActorHealth(in GramDescObj TheObject, actor a){
		
		if (a.bisMonster || a.bShootable){

			if (a.health < a.GetGibHealth()) {
				AddPostText(MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_GIB',TheObject,'[GIBBED]'));
			} else {
				AddAdjLooks(dpHealth.LookupActorHealth(a,TheObject));
			}
		}
	}
	void DescribeActorTarget(actor observer, in GramDescObj TheObject, actor a){
		string adjective;

		if ((a.bIsMonster || a.player) && a.target){
			if (a.target==observer){
				adjective=MWR_LanguageHandler.LookupGrammaticMatchCategory('DESC_TEXT_TARGET','OBSERVER',TheObject,'[TARGET:OBSERVER]%t');
			} else {
				adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_TARGET',TheObject,'[TARGET]%t');
			}

			string TargetDescription=MWR_DescriberProvider.DescribeActor(a.target);

			adjective.replace('%t',TargetDescription);

			if (a.health>0){
				AddAdjIs(adjective);
			} else {
				AddAdjWas(adjective);
			}
		}
		
	}

	//floor describers
	void DescribeFloorDamage(in GramDescObj TheObject,FLineTraceData ltd){
		sector s = ltd.HitSector;
		F3DFloor f3d = ltd.Hit3dFloor;
		
		//determine damage type and amount
		name DamageType;
		int DamageAmount;
		if (f3d){
			DamageType=f3d.model.DamageType;
			DamageAmount=f3d.model.DamageAmount;
		} else {
			DamageType=s.DamageType;
			DamageAmount=s.DamageAmount;
		}

		//build an adjective
		string adjective;
		if (DamageAmount < 0){
			adjective=MWR_LanguageHandler.LookupGrammaticMatchCategory('DESC_ADJ_HEAL',DamageType,TheObject,'[HEAL:'..DamageType..']');
		}
		if (DamageAmount > 0){
			adjective=MWR_LanguageHandler.LookupGrammaticMatchCategory('DESC_ADJ_HURT',DamageType,TheObject,'[HURT:'..DamageType..']');
		}
		
		if (adjective){AddAdjLooks(adjective);}
	}

	//wall describers
	void DescribeWallActivators(in GramDescObj TheObject,FLineTraceData ltd){
		string DescriptionAdditions;
		line thisLine=ltd.HitLine;
		int thisLineSide=ltd.LineSide;

		bool isSecret=thisLine.flags & 32;
		bool isUsabeFromHere=(thisLine.activation & SPAC_Use || thisLine.activation & SPAC_UseThrough) && (thisLineSide == Line.front || thisLine.activation & SPAC_UseBack);
		bool isAttackabeFromHere=(thisLine.activation & SPAC_Impact) && (thisLineSide == Line.front || thisLine.activation & SPAC_UseBack);
		bool isBumpabeFromHere=(thisLine.activation & SPAC_Push) && (thisLineSide == Line.front || thisLine.activation & SPAC_UseBack);
		bool willExitLevel=thisLine.special==75 || thisLine.special==243 || thisLine.special==244;
		bool knowUsable=isUsabeFromHere && !isSecret;
		bool knowAttackable=isAttackabeFromHere && !isSecret;
		bool knowBumpable=isBumpabeFromHere && !isSecret;
		
		int LockNumber=thisLine.locknumber;
		if (LockNumber<1 || LockNumber>255){
			if (thisLine.special==13 || thisLine.special==14){LockNumber=thisLine.args[3];}
			if (thisLine.special==83 || thisLine.special==85 || thisLine.special==202){LockNumber=thisLine.args[4];}
		}
		bool isLocked=(0<LockNumber && LockNumber<256);
		bool knowLocked=isLocked && !isSecret;
		
		string adjective;
		if (isSecret){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADJ_SECRET',TheObject,'[SECRET]');
			AddAdjLooks(adjective);
		}
		if (knowBumpable){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADJ_BUMPABLE',TheObject,'[BUMPABLE]');
			AddAdjLooks(adjective);
		}
		if (knowAttackable){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADJ_ATTACKABLE',TheObject,'[ATTACKABLE]');
			AddAdjLooks(adjective);
		}
		if (knowUsable){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADJ_USABLE',TheObject,'[USABLE]');
			AddAdjLooks(adjective);
		}
		if (knowLocked){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADJ_LOCKED',TheObject,'[LOCKED]');
			AddAdjLooks(adjective);
		}
		if (willExitLevel){
			adjective=MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_EXIT',TheObject,'[EXIT]');
			AddPostText(adjective);
		}
	}
	
}

//This is the LookNote addon provider.
class DescriberAddon_LookNote : MWR_DescriberAddOn{
	override bool TryDescribeHitCeiling(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		string note='',notes='';
		
		if (TryGetLookNoteName(note, TheObject, ''..ltd.HitTexture))
		{
			MWR_LanguageHandler.AppendSentence(notes,note);
		}

		int NoteNumber=ltd.HitSector.GetUDMFInt('user_looknote');
		if (TryGetLookNoteNumber(note, TheObject, NoteNumber))
		{
			MWR_LanguageHandler.AppendSentence(notes,note);
		}
		
		description=notes;
		return bool(description);
	}
	override bool TryDescribeHitFloor(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		string note='',notes='';
		
		if (TryGetLookNoteName(note, TheObject, ''..ltd.HitTexture))
		{
			MWR_LanguageHandler.AppendSentence(notes,note);
		}

		int NoteNumber=ltd.HitSector.GetUDMFInt('user_looknote');
		if (TryGetLookNoteNumber(note, TheObject, NoteNumber))
		{
			MWR_LanguageHandler.AppendSentence(notes,note);
		}
		
		description=notes;
		return bool(description);
	}
	override bool TryDescribeHitWall(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer, bool examine)
	{
		string note='',notes='';
		
		if (TryGetLookNoteName(note, TheObject, ''..ltd.HitTexture))
		{
			MWR_LanguageHandler.AppendSentence(notes,note);
		}

		int NoteNumber=ltd.HitLine.GetUDMFInt('user_looknote');
		if (TryGetLookNoteNumber(note, TheObject, NoteNumber))
		{
			MWR_LanguageHandler.AppendSentence(notes,note);
		}
		
		description=notes;
		return bool(description);
	}
	override bool TryDescribeActor(out string description, in GramDescObj TheObject, actor a, actor observer, bool examine)
	{
		string aClass=a.getClassName();
		string aTag=a.getTag();
		string aName=a.getCharacterName();
		
		if (TryGetLookNoteName(description, TheObject, aName))
		{
			return true;
		}
		if (aName!=aTag && TryGetLookNoteName(description, TheObject, aTag))
		{
			return true;
		}
		if (aTag!=aClass && TryGetLookNoteName(description, TheObject, aClass))
		{
			return true;
		}

		return false;
	}
	
	bool TryGetLookNoteName(out string strResult, GramDescObj TheObject, string NoteName)
	{
		return MWR_LanguageHandler.TryLookupGrammaticMatchFallThrough("DESC_LOOKNOTE_"..NoteName,TheObject,strResult);
	}
	
	bool TryGetLookNoteNumber(out string strResult, GramDescObj TheObject, int NoteNumber)
	{
		return TryGetLookNoteName(strResult, TheObject, ''..NoteNumber);
	}
}
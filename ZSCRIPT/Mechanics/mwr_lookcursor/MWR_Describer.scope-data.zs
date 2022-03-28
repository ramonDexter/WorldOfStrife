// Use this class as a base to build add-ons descriptions based on the given GDO
class MWR_DescriberAddOn abstract
{

	//collectors: used to accumulate descriptive info.
	protected string preText;
	protected string postText;
	protected Array<string> adjIs;
	protected Array<string> adjWas;
	protected Array<string> adjLooks;

	virtual void InitializeYourself()
	{
		clear();
	}

//	Just some pass-throughs to save some typing and simplify code
	static string LookupAddon(string KeyStr, in GramDescObj TheObject, string DefaultStr)
	{
		return MWR_LanguageHandler.LookupGrammaticMatch('DESC_ADDON_'..KeyStr,TheObject,DefaultStr);
	}
	static string LookupAddonCat(string KeyStr, string CatStr, in GramDescObj TheObject, string DefaultStr)
	{
		return MWR_LanguageHandler.LookupGrammaticMatchCategory('DESC_ADDON_'..KeyStr,CatStr,TheObject,DefaultStr);
	}
	static void AppendAddon(in out string base, string addon)
	{
		MWR_LanguageHandler.AppendSentence(base,addon);
	}

	//just a quick way to get debug info
	virtual void PrintDebugStuff()
	{
		Console.printf('PreText: '..PreText);
		Console.printf('Is count: '..adjIs.size());
		Console.printf('Was count: '..adjWas.size());
		Console.printf('Looks count: '..adjLooks.size());
		Console.printf('PostText: '..PostText);
	}

	//clear all collectors
	void clear()
	{
		preText='';
		postText='';
		adjIs.clear();
		adjWas.clear();
		adjLooks.clear();
	}
	//collect a pretext sentence
	void AddPreText(string Sentence)
	{
		MWR_LanguageHandler.AppendSentence(preText,Sentence);
	}
	//collect a posttext sentence
	void AddPostText(string Sentence)
	{
		MWR_LanguageHandler.AppendSentence(postText,Sentence);
	}
	//collect an "is" adjective
	void AddAdjIs(string adj)
	{
		if (adj){adjIs.push(adj);}
	}
	//collect a "was" adjective
	void AddAdjWas(string adj)
	{
		if (adj){adjWas.push(adj);}
	}
	//collect a "looks" adjective
	void AddAdjLooks(string adj)
	{
		if (adj){adjLooks.push(adj);}
	}

	//build an "is" sentence
	string BuildSentence_ItIs(in GramDescObj TheObject, string DescPhrase)
	{
		if (!DescPhrase){return '';}
		string sentence;
		sentence=MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_ITIS',TheObject,'[IT_IS]%d[EOL]');
		sentence.replace('%d',DescPhrase);
		return sentence;
	}
	//build a "was" sentence
	string BuildSentence_ItWas(in GramDescObj TheObject, string DescPhrase){
		if (!DescPhrase){return '';}
		string sentence;
		sentence=MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_ITWAS',TheObject,'[IT_IS]%d[EOL]');
		sentence.replace('%d',DescPhrase);
		return sentence;
	}
	//build a "looks" sentence
	string BuildSentence_ItLooks(in GramDescObj TheObject, string DescPhrase){
		if (!DescPhrase){return '';}
		string sentence;
		sentence=MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_ITLOOKS',TheObject,'[IT_IS]%d[EOL]');
		sentence.replace('%d',DescPhrase);
		return sentence;
	}
	//build text using all collections
	string BuildText(in GramDescObj TheObject){
		string text, sentence, list;
		
		//Pre
		text=preText;
		
		//Was
		list=MWR_LanguageHandler.BuildListStringAnd(adjWas);
		sentence=BuildSentence_ItWas(TheObject, list);
		MWR_LanguageHandler.AppendSentence(text,Sentence);

		//Looks
		list=MWR_LanguageHandler.BuildListStringAnd(adjLooks);
		sentence=BuildSentence_ItLooks(TheObject, list);
		MWR_LanguageHandler.AppendSentence(text,Sentence);

		//Is
		list=MWR_LanguageHandler.BuildListStringAnd(adjIs);
		sentence=BuildSentence_ItIs(TheObject, list);
		MWR_LanguageHandler.AppendSentence(text,Sentence);

		//Post
		MWR_LanguageHandler.AppendSentence(text,postText);
		
		return text;
	}

	//override these in inherited classes to do the describing
	virtual bool TryDescribeHitNothing(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitSky(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitCeiling(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitFloor(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitWall(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitActor(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return TryDescribeActor(description,TheObject,ltd.HitActor,observer,examine);}

	//Build a GDO from the given line trace hit
	bool TryDescribeLineTraceHit(out string description, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false)
	{
		switch (ltd.HitType)
		{
			case TRACE_HitNone:
				return TryDescribeHitNothing(description,TheObject,ltd,observer,examine);
			case TRACE_HasHitSky: // Unimplemented as of GZDoom 4.7.1
				return TryDescribeHitSky(description,TheObject,ltd,observer,examine);
			case TRACE_HitCeiling:
				return TryDescribeHitCeiling(description,TheObject,ltd,observer,examine);
			case TRACE_HitFloor:
				return TryDescribeHitFloor(description,TheObject,ltd,observer,examine);
			case TRACE_HitWall:
				return TryDescribeHitWall(description,TheObject,ltd,observer,examine);
			case TRACE_HitActor:
				return TryDescribeHitActor(description,TheObject,ltd,observer,examine);
			default:
				description='[ERROR]Unhandled HitType';
		}
		return false;
	}
	//use bool examine to provide addition information, for example when the actor is in inventory
	virtual bool TryDescribeActor(out string description, in GramDescObj TheObject, actor a, actor observer=null, bool examine=false){return false;}

}

//A class for using string proxies to describe a value by percentage
class MWR_DescriberPercentage
{
	protected int RefIndex[102]; //maps requested indices to actual indices
	protected string BaseType; //what type of percentage description is this
	
	protected void BuildRefIndex()
	{
		int CurRef=0;
		string ValueStr;
		for (int i=0;i<RefIndex.size();i++)
		{
			if (MWR_LanguageHandler.TryLookup("DESC_PERCENT_"..BaseType.."_"..i.."_XX",ValueStr)){
				CurRef=i;
			}
			RefIndex[i]=CurRef;
		}
	}
	
	//display RefIndex for debugging
	void PrintRefIndex()
	{
		for (int i=0;i<RefIndex.size();i++)
		{
			Console.printf('[PERCENT]'..BaseType..' '..i..'='..RefIndex[i]);
		}
	}
	
	void Initialize(string Category)
	{
		BaseType=Category;
		BuildRefIndex();
	}
	
	//Lookup a precentage describer string from Ref, an integer representing percent. Valid values are 0..101
	string LookupRef(int Ref, in GramDescObj TheObject)
	{
		clamp(Ref,0,101);
		string KeyStr="DESC_PERCENT_"..BaseType.."_"..RefIndex[Ref];
		string DefaultStr="[%"..BaseType..":"..Ref..":"..RefIndex[Ref].."]";
		return MWR_LanguageHandler.LookupGrammaticMatch(KeyStr,TheObject,DefaultStr);
	}
	
	//Lookup a precentage describer string from Amount/Max
	string LookupValue(int CurrentValue, int MaxVaule, in GramDescObj TheObject)
	{
		int Ref;
		Ref=clamp((int)(100*CurrentValue/MaxVaule),0,101);
		return LookupRef(Ref, TheObject);
	}
	
	//Lookup a precentage describer string for an actor, using health/maxhealth as the value
	string LookupActorHealth(actor a, in GramDescObj TheObject)
	{
		return LookupValue(a.health,a.GetMaxHealth(),TheObject);
	}
	
}

//This class is responsible for providing a GDO for a given tracehit or actor
class MWR_DescriberBase abstract
{
	//will be called upon being added to the describer provider
	virtual void InitializeYourself(){}
	
	//override these in inherited classes to do the describing
	virtual bool TryDescribeHitNothing(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitSky(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitCeiling(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitFloor(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitWall(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return false;}
	virtual bool TryDescribeHitActor(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false){return TryDescribeActor(TheObject,ltd.HitActor,observer,examine);}

	//use bool examine to provide addition information, for example when the actor is in inventory
	virtual bool TryDescribeActor(out GramDescObj TheObject, actor a, actor observer=null, bool examine=false){return false;}

	//Build a GDO from the given line trace hit, call appropriate describer
	bool TryDescribeLineTraceHit(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false)
	{
		switch (ltd.HitType)
		{
			case TRACE_HitNone:
				return TryDescribeHitNothing(TheObject,ltd,observer,examine);
			case TRACE_HasHitSky: // Unimplemented as of GZDoom 4.7.1
				return TryDescribeHitSky(TheObject,ltd,observer,examine);
			case TRACE_HitCeiling:
				return TryDescribeHitCeiling(TheObject,ltd,observer,examine);
			case TRACE_HitFloor:
				return TryDescribeHitFloor(TheObject,ltd,observer,examine);
			case TRACE_HitWall:
				return TryDescribeHitWall(TheObject,ltd,observer,examine);
			case TRACE_HitActor:
				return TryDescribeHitActor(TheObject,ltd,observer,examine);
			default:
				TheObject.text='[ERROR]Unhandled HitType';
		}
		return false;
	}
}

class MWR_DescriberProvider : StaticEventHandler
{
	const strIndescribable="[INDESCRIBABLE]";
	private Array<MWR_DescriberBase> _describerBase;
	private Array<MWR_DescriberAddon> _describerName;
	private Array<MWR_DescriberAddon> _describerAddon;
	protected GramDescObj gdo_text_YouSee;

	// Call these from outside to get a description
	static clearscope string DescribeLineTraceHit(FLineTraceData ltd, actor observer=null, bool examine=false, string strDefault=strIndescribable) {return GetInstance().DescribeLineTraceHit_Impl(ltd, observer, examine, strDefault);}
	static clearscope string YouSee_LineTraceHit(FLineTraceData ltd, actor observer=null, bool addons=true, bool examine=false, string strDefault=strIndescribable) {return GetInstance().YouSee_LineTraceHit_Impl(ltd, observer, addons, examine, strDefault);}
	static clearscope string DescribeActor(actor a, actor observer=null, bool examine=false, string strDefault=strIndescribable) {return GetInstance().DescribeActor_Impl(a, observer, examine, strDefault);}
	static clearscope string YouSee_Actor(actor a, actor observer=null, bool addons=true, bool examine=false, string strDefault=strIndescribable) {return GetInstance().YouSee_Actor_Impl(a, observer, addons, examine, strDefault);}

	// Call these in add-on mods to register new describers
	static void RegisterDescriberBase(class<MWR_DescriberBase> d) {GetInstance().RegisterDescriberBase_Impl(d);}
	static void RegisterDescriberName(class<MWR_DescriberAddon> d) {GetInstance().RegisterDescriberName_Impl(d);}
	static void RegisterDescriberAddon(class<MWR_DescriberAddon> d) {GetInstance().RegisterDescriberAddon_Impl(d);}
	
	private clearscope virtual void InitializeYourself()
	{
		MWR_LanguageHandler.TryLanguageLookupGDO('DESC_TEXT_YOUSEE',gdo_text_YouSee,'[YOU_SEE]%o[EOL]');

		// Sanity check some values
		if (gdo_text_YouSee.text.IndexOf('%o')<0){
			Console.Printf('[ERROR]MWR_Describer: Bad DESC_TEST_YOUSEE');
			gdo_text_YouSee.text='[YOU_SEE]%o[EOL]';
		}

	}

	private clearscope static MWR_DescriberProvider GetInstance()
	{
		let h = MWR_DescriberProvider(StaticEventHandler.Find('MWR_DescriberProvider'));

		if (h == null)
		{
			ThrowAbortException("Could not find the instance of MWR_DescriberProvider.");
		}

		return h;
	}

	private clearscope string DescribeLineTraceHit_Impl(FLineTraceData ltd, actor observer=null, bool examine=false, string strDefault=strIndescribable)
	{
		string description;
		if (TryDescribeLineTraceHitToString(description, ltd, observer, examine))
		{
			return description;
		}
		return strDefault;
	}
	private clearscope bool TryDescribeLineTraceHitToGdo(out GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false)
	{
		for (uint i = 0; i < _describerBase.Size(); i++)
		{
			if (_describerBase[i].TryDescribeLineTraceHit(TheObject, ltd, observer, examine))
			{
				string TheName;
				if (TryNameLineTraceHit(TheName,TheObject,ltd,observer,examine))
				{
					ApplyName(TheObject,TheName);
				}
				return true;
			}
		}
		
		return false;
	}
	private clearscope bool TryDescribeLineTraceHitToString(out string description, FLineTraceData ltd, actor observer=null, bool examine=false)
	{
		GramDescObj TheObject;
		if (TryDescribeLineTraceHitToGdo(TheObject, ltd, observer, examine))
		{
			description=TheObject.text;
			return true;
		}
		return false;
	}
	
	private clearscope string DescribeActor_Impl(Actor a, actor observer=null, bool examine=true, string strDefault=strIndescribable)
	{
		string description;
		if (TryDescribeActorToString(description, a, observer, examine))
		{
			return description;
		}
		return strDefault;
	}
	private clearscope bool TryDescribeActorToGdo(out GramDescObj TheObject, Actor a, actor observer=null, bool examine=false)
	{
		for (uint i = 0; i < _describerBase.Size(); i++)
		{
			if (_describerBase[i].TryDescribeActor(TheObject, a, observer, examine))
			{
				string TheName;
				if (TryNameActor(TheName,TheObject,a,observer,examine))
				{
					ApplyName(TheObject,TheName);
				}
				return true;
			}
		}

		return false;
	}
	private clearscope bool TryDescribeActorToString(out string description, actor a, actor observer=null, bool examine=false)
	{
		GramDescObj TheObject;
		if (TryDescribeActorToGdo(TheObject, a, observer, examine))
		{
			description=TheObject.text;
			return true;
		}
		return false;
	}

	private clearscope bool TryNameLineTraceHit(out string TheName, in GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false)
	{
		for (uint i = 0; i < _describerName.Size(); i++)
		{
			if (_describerName[i].TryDescribeLineTraceHit(TheName, TheObject, ltd, observer, examine))
			{
				return true;
			}
		}
		return false;
	}
	private clearscope bool TryNameActor(out string TheName, in GramDescObj TheObject, Actor a, actor observer=null, bool examine=false)
	{
		for (uint i = 0; i < _describerName.Size(); i++)
		{
			if (_describerName[i].TryDescribeActor(TheName, TheObject, a, observer, examine))
			{
				return true;
			}
		}
		return false;
	}
	
	static clearscope void ApplyName(in GramDescObj TheObject, string TheName)
	{
		string NameTemplate = MWR_LanguageHandler.LookupGrammaticMatch('DESC_TEXT_NAMED', TheObject, "%o[NAMED]\"%n\"");
		NameTemplate.replace('%o',TheObject.text);
		NameTemplate.replace('%n',TheName);
		TheObject.text=NameTemplate;
	}

	//gdoSentence = gdo_text_YouSee with %o replaced with TheObject
	clearscope void BuildSentence_YouSee(out GramDescObj gdoSentence, in GramDescObj TheObject)
	{
		MWR_LanguageHandler.SetGdo(gdoSentence,gdo_text_YouSee);
		MWR_LanguageHandler.TryCombineGdoText(gdoSentence,'%o',TheObject);
	}
	private clearscope string YouSee_LineTraceHit_Impl(FLineTraceData ltd, actor observer=null, bool tryAddons=true, bool examine=false, string strDefault=strIndescribable)
	{
		GramDescObj TheObject;
		GramDescObj TheSentence;
		if (TryDescribeLineTraceHitToGdo(TheObject, ltd, observer, examine))
		{
			BuildSentence_YouSee(TheSentence, TheObject);
			
			//Try the addons
			if (tryAddons)
			{
				string strAddons;
				if (TryDescribeLineTraceHitAddons(strAddons,TheObject,ltd,observer,examine))
				{
					MWR_LanguageHandler.AppendSentence(TheSentence.text,strAddons);
				}
			}
			
			return TheSentence.text;
		}
		return strDefault;
	}
	private clearscope string YouSee_Actor_Impl(actor a, actor observer=null, bool tryAddons=true, bool examine=false, string strDefault=strIndescribable)
	{
		GramDescObj TheObject;
		GramDescObj TheSentence;
		if (TryDescribeActorToGdo(TheObject, a, observer, examine))
		{
			BuildSentence_YouSee(TheSentence, TheObject);
			
			//Try the addons
			if (tryAddons)
			{
				string strAddons;
				if (TryDescribeActorAddons(strAddons, TheObject, a, observer, examine))
				{
					MWR_LanguageHandler.AppendSentence(TheSentence.text,strAddons);
				}
			}
			
			return TheSentence.text;
		}
		return strDefault;
	}
	private clearscope bool TryDescribeActorAddons(out string Description, GramDescObj TheObject, actor a, actor observer=null, bool examine=false)
	{
		for (uint i = 0; i < _describerAddon.Size(); i++)
		{
			if (_describerAddon[i].TryDescribeActor(Description, TheObject, a, observer, examine))
			{
				return true;
			}
		}

		return false;
	}
	private clearscope bool TryDescribeLineTraceHitAddons(out string Description, GramDescObj TheObject, FLineTraceData ltd, actor observer=null, bool examine=false)
	{
		for (uint i = 0; i < _describerAddon.Size(); i++)
		{
			if (_describerAddon[i].TryDescribeLineTraceHit(Description, TheObject, ltd, observer, examine))
			{
				return true;
			}
		}

		return false;
	}

	private void RegisterDescriberBase_Impl(class<MWR_DescriberBase> d){
		_describerBase.Insert(0, MWR_DescriberBase(new(d)));
		_describerBase[0].InitializeYourself();
	}
	private void RegisterDescriberName_Impl(class<MWR_DescriberAddon> d){
		_describerName.Insert(0, MWR_DescriberAddon(new(d)));
		_describerName[0].InitializeYourself();
	}
	private void RegisterDescriberAddon_Impl(class<MWR_DescriberAddon> d){
		_describerAddon.Insert(0, MWR_DescriberAddon(new(d)));
		_describerAddon[0].InitializeYourself();
	}

	override void OnRegister()
	{
		Super.OnRegister();
		string ThisClassName=GetClassName();
		console.printf('MWR_DescriberProvider registered as '..ThisClassName);//DEBUG
		InitializeYourself();
		// Register default describer(s) here
		RegisterDescriberBase_Impl('DescriberBase_Default');
		RegisterDescriberBase_Impl('DescriberBase_Inventory');
		//RegisterDescriberName_Impl();
		RegisterDescriberName_Impl('DescriberAddon_Name');
		//RegisterDescriberAddon_Impl();
		RegisterDescriberAddon_Impl('DescriberAddon_Default');
		RegisterDescriberAddon_Impl('DescriberAddon_LookNote');
	}
}

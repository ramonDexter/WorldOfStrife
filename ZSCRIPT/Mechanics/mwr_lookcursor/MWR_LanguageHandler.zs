enum GramGender { //Grammatic Gender
	GRMGEN_Indeterminate,
	GRMGEN_Masculine,
	GRMGEN_Feminine,
	GRMGEN_Neutral,
	GRMGEN_Object
}

enum GramNumber { //Grammatic Nunber
	GRMNUM_Indeterminate,
	GRMNUM_Singular,
	GRMNUM_Dual,
	GRMNUM_Plural
}

struct GramDescObj{ //Grammatic Description Object
	GramGender gender;
	GramNumber number;
	string text;
}

class  MWR_LanguageHandler : StaticEventHandler {

	string lang_text_combine;
	string lang_list_and;
	string lang_list_or;
	string lang_list_more;
	string lang_list_oxford;

    override void OnRegister(){
		console.printf('MWR_LanguageHandler Registered');//DEBUG
		
		InitVars();
    }
	
	private bool InitVars(){
		bool AllGood=true;
		lang_text_combine=LanguageLookupString('LANG_TEXT_COMBINE','%a[COMBINE]%b');
		lang_list_and=LanguageLookupString('LANG_LIST_AND','%a[AND]%b');
		lang_list_or=LanguageLookupString('LANG_LIST_OR','%a[OR]%b');
		lang_list_more=LanguageLookupString('LANG_LIST_MORE','%a[MORE]%b');
		lang_list_oxford=LanguageLookupString('LANG_LIST_OXFORD','%a[OXFORD]');

		return AllGood;
	}

    static clearscope MWR_LanguageHandler GetInstance(){
        let h = MWR_LanguageHandler(StaticEventHandler.Find('MWR_LanguageHandler'));

        if (h == null){
            ThrowAbortException("Could not find the instance of MWR_LanguageHandler.");
        }

        return h;
    }

//	Tries to lookup the provided key with stringtable.localize, passes back value, returns success
//	KeyStr does not need the leading '$' code, it will be added when passed
//	Any space or dash in KeyStr will be swapped for underscore.
//	KeyStr==ValueStr is a fail. When EmptyIsFail an empty ValueStr is also a fail.
	static clearscope bool TryLookup(string KeyStr, out string ValueStr, bool EmptyIsFail=true){
		KeyStr.replace(" ","_");
		KeyStr.replace("-","_");
		ValueStr=stringtable.localize("$"..KeyStr);
		return !(KeyStr==ValueStr || (EmptyIsFail && !ValueStr));
	}
	
//	Iterrates KeysStrs and tries each one in TryLookup and returns the first true, if any.
	static clearscope bool TryLookupArray(array<string> KeyStrs, out string ValueStr, bool EmptyIsFail=true){
		for (int i=0;i<=KeyStrs.size();i++){
			if (TryLookup(KeyStrs[i],ValueStr,EmptyIsFail)){return true;}
		}
		return false;
	}
	
//	Calls TryLookup with KeyStr. On fail returns DefaultStr.
	static clearscope string LanguageLookupString(string KeyStr, string DefaultStr='', bool ReplaceEmpty=true){
		string ValueStr;
		if (!TryLookup(KeyStr,ValueStr,ReplaceEmpty)){
			ValueStr=DefaultStr;
		}
		return ValueStr;
	}

//	Calls TryLookup with KeyStr. On fail chooses DefaultStr. Then converts string to GDO
//	Returns conversion success, output is in gdo
	static clearscope bool TryLanguageLookupGDO(string KeyStr, out GramDescObj gdo, string DefaultStr='', bool ReplaceEmpty=true){
		string ValueStr;
		if (!TryLookup(KeyStr,ValueStr,ReplaceEmpty)){
			ValueStr=DefaultStr;
		}
		return TryStringToGramDescObj(gdo,ValueStr);
	}

//	Does a grammatic lookup by appending '_XX' to KeyStr depending on provided gg and gn
//	returns success, strResult holds the lookup return
	static clearscope bool TryLookupGrammaticMatch(string KeyStr, GramGender gg, GramNumber gn, out string strResult){
		string StrGG, StrGN;
		switch (gg){
			case GRMGEN_Masculine:
				StrGG="M";
				break;
			case GRMGEN_Feminine:
				StrGG="F";
				break;
			case GRMGEN_Neutral:
				StrGG="N";
				break;
			case GRMGEN_Object:
				StrGG="O";
				break;
			default:
				StrGG="X";
				break;
		}
		switch (gn){
			case GRMNUM_Singular:
				StrGN="S";
				break;
			case GRMNUM_Dual:
				StrGN="D";
				break;
			case GRMNUM_Plural:
				StrGN="P";
				break;
			default:
				StrGN="X";
				break;
		}
		KeyStr=KeyStr..'_'..StrGG..StrGN;
		return TryLookup(KeyStr,strResult);
	}

//	same as TryLookupGrammaticMatch but will try fallthroughs with gender and number
	static clearscope bool TryLookupGrammaticMatchFallThrough(string KeyStr, GramDescObj TheObject, out string strResult){
		//First try an exact lookup
		if (TryLookupGrammaticMatch(KeyStr, TheObject.gender, TheObject.number, StrResult)){
			return true;
		}
		
		//If the number is dual, try plural
		if (TheObject.number==GRMNUM_Dual && TryLookupGrammaticMatch(KeyStr, TheObject.gender, GRMNUM_Plural, StrResult)){
			return true;
		}
		
		//Try indeterminate gender
		if (TryLookupGrammaticMatch(KeyStr, GRMGEN_Indeterminate, TheObject.number, StrResult)){
			return true;
		}
		
		//If the number is dual, try indeterminate gender and plural
		if (TheObject.number==GRMNUM_Dual && TryLookupGrammaticMatch(KeyStr, GRMGEN_Indeterminate, GRMNUM_Plural, StrResult)){
			return true;
		}
		
		//Try indeterminate number
		if (TryLookupGrammaticMatch(KeyStr, TheObject.gender, GRMNUM_Indeterminate, StrResult)){
			return true;
		}

		//Try indeterminate gender and number
		if (TryLookupGrammaticMatch(KeyStr, GRMGEN_Indeterminate, GRMNUM_Indeterminate, StrResult)){
			return true;
		}
		
		//Give up
		return false;
	}

//	Try to lookup a grammatic match KeyStr for TheObject. If exact match not found, try indeterminates.
//	If no match found, returns StrDefault.
	static clearscope string LookupGrammaticMatch(string KeyStr, GramDescObj TheObject, string StrDefault)
	{
		string StrResult;
		
		//try lookups and fallthroughs
		if (TryLookupGrammaticMatchFallThrough(KeyStr, TheObject, StrResult))
		{
			return StrResult;
		}

		//give up, return default
		return StrDefault;
		
	}

//	First tries with a category, if fails then tries without
	static clearscope string LookupGrammaticMatchCategory(string KeyStr, string category, GramDescObj TheObject, string StrDefault){
		string StrResult='';
		//First try with category
		if (TryLookupGrammaticMatchFallThrough(KeyStr..'_'..category, TheObject, StrResult))
		{
			return StrResult;
		}
		
		//If that didn't work, try without the category
		if (TryLookupGrammaticMatchFallThrough(KeyStr, TheObject, StrResult))
		{
			return StrResult;
		}

		//give up, return default
		return StrDefault;
	}

//	Converts a string to a Grammatic Describe Object.
//	First char should be M/F/N/X for gender
//	Second should be S/D/P/X for number
//	The rest is the description text
	static clearscope bool TryStringToGramDescObj(out GramDescObj TheObject, string strInput)
	{
		if (strInput.length() < 2){return false;}
		int g,n,dummy;
		g=strInput.Mid(0,1).GetNextCodePoint(0);
		switch (g)
		{
			case 77://"M"
				TheObject.gender=GRMGEN_Masculine;
				break;
			case 70://"F"
				TheObject.gender=GRMGEN_Feminine;
				break;
			case 78://"N"
				TheObject.gender=GRMGEN_Neutral;
				break;
			case 79://"O"
				TheObject.gender=GRMGEN_Object;
				break;
			case 88://"X"
				TheObject.gender=GRMGEN_Indeterminate;
				break;
			default:
				return false;
				break;
		}
		n=strInput.Mid(1,1).GetNextCodePoint(0);
		switch (n)
		{
			case 83://"S"
				TheObject.number=GRMNUM_Singular;
				break;
			case 68://"D"
				TheObject.number=GRMNUM_Dual;
				break;
			case 80://"P"
				TheObject.number=GRMNUM_Plural;
				break;
			case 88://"X"
				TheObject.number=GRMNUM_Indeterminate;
				break;
			default:
				return false;
				break;
		}
		if (strInput.length() > 2)
		{
			TheObject.text=strInput.mid(2);
		}
		return true;
	}

	//Uses the literal string and assigns indeterminate gender and number
	static clearscope void StringToGdoGeneric(out GramDescObj TheObject, string strInput)
	{
		TheObject.gender=GRMGEN_Indeterminate;
		TheObject.number=GRMNUM_Indeterminate;
		TheObject.text=strInput;
	}

	// Description may contain 3 strings separated by '&', each one for a grammatical
	// number: singular, dual, plural. This function will select the correct one based
	// on Quantity. Also replaces '%q' with Quantity. Returns the final string.
	static clearscope bool TryStringToGramDescObjQuantity(out GramDescObj TheObject, string Description, int Quantity)
	{
		string thisDescription;
		Array<String> tokens;
		Description.Split(tokens,'&');
		
		if (tokens.size()<2){
			tokens.push(tokens[0]);
		}
		if (tokens.size()<3){
			tokens.push(tokens[1]);
		}
		
		switch (Quantity){
			case 1:
				thisDescription=tokens[0];
				break;
			case 2:
				thisDescription=tokens[1];
				break;
			default:
				thisDescription=tokens[2];
				break;
		}
		
		thisDescription.replace("%q",''..Quantity);
		return TryStringToGramDescObj(TheObject, thisDescription);
	}

	// combines the given string using the sentence combining rules, returns results
	static clearscope string CombineSentences(string a, string b){
		return GetInstance().CombineSentences_Impl(a,b);
	}

	// same as CombineSentences but changes the base string in place
	static clearscope void AppendSentence(in out string base, string addition){
		base=CombineSentences(base,addition);
	}
	
	//Template should be like "%a %b", return will have "%a" replaced with a and "%b" replaced with b
	//if either a or b is an empty string, the other will be returned without using the template.
	static clearscope string CombineText(string template,string a, string b){
		string output;
		if (a) {
			if (b){
				output=template;
				output.replace('%a',a);
				output.replace('%b',b);
			} else {
				output=a;
			}
		} else {
			if (b){
				output=b;
			} else {
				output='';
			}
		}
		return output;
	}
	
	//Copy gdo features from source to target
	static clearscope void SetGdo(in out GramDescObj target, GramDescObj source){
		target.gender=source.gender;
		target.number=source.number;
		target.text=source.text;
	}
	
//	Any indeterminates in target will be replaced with source. Text is unaltered. Return tells if any replacement(s) were made.
	static clearscope bool CombineGdo(in out GramDescObj target, GramDescObj source){
		bool result=false;
		if (target.Gender==GRMGEN_Indeterminate){
			target.Gender=source.Gender;
			result=true;
		}
		if (target.Number==GRMNUM_Indeterminate){
			target.Number=source.Number;
			result=true;
		}
		return result;
	}

//	Replace KeyCode in target.text with source.text and then combines the gdo objects.
	static clearscope bool TryCombineGdoText(in out GramDescObj target, string KeyCode, GramDescObj source){
		if (target.text.IndexOf(KeyCode)<0){
			return false;
		} else {
			target.text.replace(KeyCode,source.text);
			CombineGDO(target,source);
			return true;
		}
	}

	static clearscope string BuildListString(array<string> aStr, string TemplateCombine2, string TemplateCombineMore, string TemplateOxford){
		string result;
		if (aStr.size()==0){return '';}
		if (aStr.size()==1){return aStr[0];}
		
		//combine first n-1 items
		result=aStr[0];
		for (int i=1; i < aStr.size()-1; i++){
			result=CombineText(TemplateCombineMore,result,aStr[i]);
		}
		
		//add oxford
		if (aStr.size()>2){
			string oxford=TemplateOxford;
			oxford.replace('%a',result);
			result=oxford;
		}
		
		//final combine
		result=CombineText(TemplateCombine2,result,aStr[aStr.size()-1]);

		return result;
	}
	
	static clearscope string BuildListStringAnd(array<string> aStr){
		return GetInstance().BuildListStringAnd_Impl(aStr);
	}
	static clearscope string BuildListStringOr(array<string> aStr){
		return GetInstance().BuildListStringOr_Impl(aStr);
	}
	
	// combine a and b using lang_text_add template
	clearscope string CombineSentences_Impl(string a, string b){		
		return CombineText(lang_text_combine,a,b);
	}
	// joins array of strings into a single string using language rules 'and'
	clearscope string BuildListStringAnd_Impl(array<string> aStr){
		return BuildListString(aStr, lang_list_and, lang_list_more, lang_list_oxford);
	}
	// joins array of strings into a single string using language rules 'or'
	clearscope string BuildListStringOr_Impl(array<string> aStr){
		return BuildListString(aStr, lang_list_or, lang_list_more, lang_list_oxford);
	}
}

//version "3.2"

class LowDetailHandler : EventHandler
{
	PlayerInfo ptr;
	override void UiTick()
	{
		if (ptr)
			Shader.SetEnabled(ptr, "lowdetail", (CVar.FindCVar("gl_lowdetail").GetInt() != 0));
	}
	override void PlayerEntered(PlayerEvent e)
	{
		ptr = players[e.PlayerNumber];
	}
}

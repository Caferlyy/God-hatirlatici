#include sourcemod
#include warden

#pragma semicolon 1

bool godalcam = false;

#define CT          3
Handle Delaytimer[MAXPLAYERS + 1] = null;
ConVar godluel_hatirlat = null;
public Plugin myinfo = 
{
	name = "God almayı hatıratıyor kankka", 
	author = "Caferly", 
	description = "gkeserler iki şişe biraya", 
	version = "1.0", 
	url = "Caferly"
};

public void OnPluginStart()
{
	HookEvent("round_start", godkontrol);
	RegConsoleCmd("sm_godel", GodEL);
	godluel_hatirlat = CreateConVar("sm_god_timer", "10", "Kaç dakika arayla komutçuya sorsun?", FCVAR_NOTIFY, true, 1.0);
	CreateTimer(134.0, godhatirlatici, _,TIMER_REPEAT);
} 

public Action:godhatirlatici(Handle:timer,client)
{
	Event newevent_message = CreateEvent("cs_win_panel_round");
newevent_message.SetString("funfact_token", "<font class='fontSize-xxl'><font color='#FF5733'>!godel</font><font color='#FF0000'> yazarak godlu el alabilirsiniz.</font>");

for(int z = 1; z <= MaxClients; z++)
  if(IsClientInGame(z) && !IsFakeClient(z))
    newevent_message.FireToClient(z);
if (warden_iswarden(client))
	{           
           Bilgi(client);
           }
newevent_message.Cancel(); 
PrintToChatAll(" \x05[SM] \x0E!godel \x06yazarak \x0Egodlu el oynatmak için \x05god alabilirsiniz.");
	return Plugin_Continue;
}

Bilgi(client)
{
		Menu menu = new Menu(Menu_Callback);
		menu.SetTitle("▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\n   ★  Godlu El - Hatırlatıcı ★\n▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ \n Godlu oynatmak istiyor musunuz?");
		menu.AddItem("1", "→ ! Evet, İstiyorum!");
		menu.AddItem("2", "→ ! Hayır, İstemiyorum!");
		menu.ExitBackButton = false;
		menu.ExitButton = false;
		menu.Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
}

public int Menu_Callback(Menu menu, MenuAction action, int client, int select)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menu.GetItem(select, Item, sizeof(Item));
		if (StrEqual(Item, "1", true))
		{
			if (warden_iswarden(client))
	{
		godalcam = true;
		Event newevent_message = CreateEvent("cs_win_panel_round");
newevent_message.SetString("funfact_token", "<font class='fontSize-xxl'><font color='#FF5733'>Komutçu</font><font color='#6BFF33'> Diğer elin godlu olmasını istedi.</font>");

for(int z = 1; z <= MaxClients; z++)
  if(IsClientInGame(z) && !IsFakeClient(z))
    newevent_message.FireToClient(z);
                                
newevent_message.Cancel(); 
		PrintToChatAll("[SM] \x0BKomutçu \x04Diğer elin \x02god \x04olmasını istedi!", client);
	}
		}
		else if (StrEqual(Item, "2", true))
		{
			godalcam = false;
			Event newevent_message = CreateEvent("cs_win_panel_round");
newevent_message.SetString("funfact_token", "<font class='fontSize-xxl'><font color='#FF5733'>Komutçu</font><font color='#6BFF33'> Diğer elin godlu olmasını istemedi!</font>");

for(int z = 1; z <= MaxClients; z++)
  if(IsClientInGame(z) && !IsFakeClient(z))
    newevent_message.FireToClient(z);
                                
newevent_message.Cancel(); 
		PrintToChatAll("[SM] \x0BKomutçu \x04Diğer elin \x02god \x04olmasını istemedi!");
			Delaytimer[client] = CreateTimer(godluel_hatirlat.FloatValue * 60.0, DelaySOR, client, TIMER_FLAG_NO_MAPCHANGE);
			PrintToChat(client, "[SM] \x04%d dakika \x01sonra tekrar sorulacak.", godluel_hatirlat.IntValue);
		}
		delete menu;
	}
} 
public void warden_OnWardenCreated(int client)
{
	Delaytimer[client] = CreateTimer(godluel_hatirlat.FloatValue * 60.0, DelaySOR, client, TIMER_FLAG_NO_MAPCHANGE);
}				   

public Action DelaySOR(Handle timer, int client)
{
		Bilgi(client);
}
public Action GodEL(int client, int args)
{
	if (warden_iswarden(client))
	{
		

		Event newevent_message = CreateEvent("cs_win_panel_round");
newevent_message.SetString("funfact_token", "<font class='fontSize-xxl'><font color='#FF5733'>Komutçu</font><font color='#6BFF33'> Diğer elin godlu olmasını istedi.</font>");

for(int z = 1; z <= MaxClients; z++)
  if(IsClientInGame(z) && !IsFakeClient(z))
    newevent_message.FireToClient(z);
                                
newevent_message.Cancel(); 
		PrintToChatAll("[SM] \x0BKomutçu \x04Diğer elin \x02god \x04olmasını istedi!", client);
	}
}

public Action godkontrol(Event event, const char[] name, bool dontBroadcast)
{
	if (godalcam)
	{
		Handle hHudText = CreateHudSynchronizer();
		SetHudTextParams(-1.0, -0.5, 5.0, 255, 0, 0, 255, 2, 1.0, 0.1, 0.2);
		for (int i = 1; i <= MaxClients; i++)
		{
			if (!IsFakeClient(i) && IsClientInGame(i))
			{
				ShowSyncHudText(i, hHudText, "! BU EL GODLU !");
				PrintToChat(i, "[SM] \x02Komutçuya ve korumaya otomatik olarak god verildi.");
			}
			if (GetClientTeam(i) == CT && !IsFakeClient(i) && IsClientInGame(i))
			{
				SetEntProp(i, Prop_Data, "m_takedamage", 0, 1);
			}
		}
		godalcam = false;
	}
} 
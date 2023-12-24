// Custom GSC script to always be russman on highrise
#include maps\mp\_utility;
#include common_scripts\utility;

init()
{    
    thread onplayerconnect();
}

onplayerconnect()
{
	while(true)
	{
		level waittill("connecting", player);
		assign_selected_team();
	}
}

assign_selected_team()
{
    selected_team = getdvarintdefault( "TEAM_SELECT", "none" );
    switch( selected_team )
    {
        case 1:
            level.should_use_cia = 1;
        break;

        case 2:
            level.should_use_cia = 0;
        break;        
    }
}

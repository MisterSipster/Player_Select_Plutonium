// Custom GSC script to select player
#include maps\mp\zm_transit;
#include common_scripts\utility;
#include maps\mp\_utility;

init()
{    
    replaceFunc(maps\mp\zm_transit::assign_lowest_unused_character_index, ::assign_selected_player);
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

assign_selected_player()
{
    charindexarray = [];
    charindexarray[0] = 0;
    charindexarray[1] = 1;
    charindexarray[2] = 2;
    charindexarray[3] = 3;
    players = get_players();
    selected_player = getdvarintdefault( "PLAYER_SELECT", "none" );
    if ( players.size == 1 )
    {
        		// 0 = russman, 1 = reporter, 2 = mysty, 3 = engineer
    return_value = 0;
    switch( selected_player )
    {
        case 0:        
          charindexarray = array_randomize( charindexarray );
          return_value = charindexarray[0];
        break;        
        case 1:
            return_value = 0;
        break;
        case 2:
            return_value = 1;
        break;    
        case 3:
            return_value = 2;
        break;
        case 4:
            return_value = 3;
        break;   
    }
    return return_value;
    }
    else
    {
        n_characters_defined = 0;

        foreach ( player in players )
        {
            if ( isdefined( player.characterindex ) )
            {
                arrayremovevalue( charindexarray, player.characterindex, 0 );
                n_characters_defined++;
            }
        }

        if ( charindexarray.size > 0 )
        {
            if ( n_characters_defined == players.size - 1 )
            {
                if ( !( isdefined( level.has_weasel ) && level.has_weasel ) )
                {
                    level.has_weasel = 1;
                    return 3;
                }
            }

            charindexarray = array_randomize( charindexarray );

            if ( charindexarray[0] == 3 )
                level.has_weasel = 1;

            return charindexarray[0];
        }
    }

    return 0;
}


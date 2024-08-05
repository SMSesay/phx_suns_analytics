{{
    config(materialized='view')
}}

with source_royce_shots as (

    select
    index,
    "SEASON_1" as season,
    "TEAM_ID" as team_id,
    "TEAM_NAME" as team_name,
    "PLAYER_ID" as player_id,
    "PLAYER_NAME" as player_name,
    "POSITION_GROUP" as position_group,
    "POSITION" as position,
    "GAME_DATE" as game_date,
    "GAME_ID" as game_id,
    "HOME_TEAM" as home_team,
    "AWAY_TEAM" as away_team,
    "EVENT_TYPE" as event_type,
    "SHOT_MADE" as shot_made,
    "ACTION_TYPE" as action_type,
    "SHOT_TYPE" as shot_type,
    "BASIC_ZONE" as basic_zone,
    "ZONE_NAME"  as zone_name, 
    "ZONE_RANGE" as zone_range,
    "LOC_X" as loc_x,
    "LOC_Y" as loc_y,
    "SHOT_DISTANCE" as shot_distance,
    "QUARTER" as quarter,
    "MINS_LEFT" as mins_left,
    "SECS_LEFT" as secs_left 
    from {{source('phx_raw_shots', 'royce_oneale_shots')}}
)

select * from source_royce_shots
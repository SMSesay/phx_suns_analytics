{{
    config(materialized='view')
}}

with made_actions as (

    SELECT
        player_id,
        player_name,
        team_id,
        team_name,
        action_type,
        count(*) as made_shots
    FROM {{ref('stg_book_shots')}}
    WHERE 
        shot_made = true

    GROUP BY 
        player_id, player_name, team_id, team_name, action_type
),

missed_actions as (
    SELECT
        player_id,
        player_name,
        team_id,
        team_name,
        action_type,
        count(*) as missed_shots
    FROM {{ref('stg_book_shots')}}
    WHERE 
        shot_made = false

    GROUP BY 
        player_id, player_name, team_id, team_name, action_type
),

joined_actions as (

    SELECT
        miss.player_id,
        miss.player_name,
        miss.team_id,
        miss.team_name,
        miss.action_type,
        missed_shots,
        made_shots,
        missed_shots+made_shots as total_shots
    FROM missed_actions miss
    INNER JOIN made_actions made
    ON miss.player_id = made.player_id
    AND miss.player_name = made.player_name
    AND miss.team_id = made.team_id

)

select * from joined_actions
{{
    config(materialized='view')
}}

with book_shots_made as (

    SELECT
        player_id,
        player_name,
        season,
        team_name,
        position,
        game_date,
        home_team || ' @ ' || away_team as matchup,
        count(*) as shots_made
    FROM {{ref('stg_book_shots')}}

    WHERE
        shot_made = true

    GROUP BY player_id, player_name, season, team_name,
            position, game_date, matchup
),

book_shots_missed as (

    SELECT
        player_id,
        player_name,
        season,
        team_name,
        position,
        game_date,
        home_team || ' @ ' || away_team as matchup,
        count(*) as shots_missed
    FROM {{ref('stg_book_shots')}}

    WHERE
        shot_made = false

    GROUP BY player_id, player_name, season, team_name, position,
            game_date, matchup

),

joined_book_shots as (

    SELECT 
        miss.player_id,
        miss.player_name,
        miss.season,
        miss.team_name,
        miss.position,
        miss.game_date,
        miss.matchup,
        shots_missed,
        shots_made,
        shots_missed + shots_made as total_shots,
        ROUND(shots_made / (shots_missed + shots_made)::NUMERIC,2 ) as field_goal_perc
    
    FROM book_shots_missed as miss
    
    INNER JOIN book_shots_made as made ON
    miss.player_id = made.player_id
    AND miss.player_name = made.player_name
    AND miss.season = made.season
    AND miss.team_name = made.team_name
    AND miss.position = made.position
    AND miss.game_date = made.game_date

)

SELECT * FROM joined_book_shots



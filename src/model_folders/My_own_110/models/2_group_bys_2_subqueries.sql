with

lineups as (

    select * from {{ ref('stg_lineups') }}

),

appearances as (

    select * from {{ ref('stg_appearances') }}

),

joined as (

    select
        l.*,
        a.minutes_played

    from lineups l
    join appearances a
    on l.game_id = a.game_id
    and l.player_id = a.player_id

),

awfully_complex_query as (

    select
        m.player_id,
        s.game_id,
        m.avg_minutes_played,
        s.max_season

    from (

        select
            player_id,
            game_id,
            max(season) as max_season

        from joined
--         group by player_id
        group by player_id, game_id

        ) as s

    join (

        select
            player_id,
            avg(minutes_played) as avg_minutes_played

        from joined
        group by player_id

    ) as m

    on s.player_id = m.player_id

)

    select * from awfully_complex_query
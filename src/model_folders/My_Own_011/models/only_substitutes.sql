with

all_types as (

    select * from {{ ref('stg_lineups') }}

),

only_subs as (

    select
        player_id,
        season

    from all_types
    where type='substitute'

)

    select * from only_subs

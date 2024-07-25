with

clubs as (

    select * from {{ source('transfermarkt', 'clubs') }}
    order by season
    limit {{ var('limit_used_in_experiment')['stg_clubs'] }}

),

final as (

    select
        club_id,
        season

    from clubs

)

    select * from final
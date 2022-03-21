
with base as (

    select * 
    from {{ ref('stg_google_play__stats_crashes_overview_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_play__stats_crashes_overview_tmp')),
                staging_columns=get_stats_crashes_overview_columns()
            )
        }}
        
    from base
),

final as (
    
    select

        date as report_date,
        package_name,
        daily_anrs,
        daily_crashes,
        _fivetran_synced

    from fields
)

select * from final
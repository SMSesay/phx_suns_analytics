{{
    config(materialized='view')
}}

with source_kd_shots as (

    select * from {{source('phx_raw_shots', 'kevin_durant_shots')}}
)

select * from source_kd_shots
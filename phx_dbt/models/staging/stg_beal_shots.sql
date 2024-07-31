{{
    config(materialized='view')
}}

with source_beal_shots as (

    select * from {{source('phx_raw_shots', 'bradley_beal_shots')}}
)

select * from source_beal_shots
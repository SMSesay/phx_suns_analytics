{{
    config(materialized='view')
}}

with source_bol_shots as (

    select * from {{source('phx_raw_shots', 'bol_bol_shots')}}
)

select * from source_bol_shots
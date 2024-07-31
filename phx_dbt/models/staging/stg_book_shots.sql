{{
    config(materialized='view')
}}

with source_book_shots as (

    select * from {{source('phx_raw_shots', 'devin_booker_shots')}}
)

select * from source_book_shots
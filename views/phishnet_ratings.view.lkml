view: phishnet_ratings {
  sql_table_name: dean_looker_phish_thesis.phishnet_ratings ;;

  dimension: rating {
    description: "Rating as a dimension"
    type: number
    sql: ${TABLE}.rating ;;
  }

  measure: rating_measure {
    label: "Rating"
    description: "Rating used with MAX() to make available as measure"
    type: max
    sql: ${rating} ;;
  }

  dimension_group: showdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.showdate ;;
  }


  dimension: votes {
    label: "# of Votes"
    type: number
    sql: ${TABLE}.votes ;;
  }



#   dimension: city {
#     type: string
#     sql: ${TABLE}.city ;;
#   }
#
#   dimension: state {
#     type: string
#     sql: ${TABLE}.state ;;
#   }
#
#   dimension: country {
#     type: string
#     map_layer_name: countries
#     sql: ${TABLE}.country ;;
#   }
#
#    dimension: venue {
#       type: string
#       sql: ${TABLE}.venue ;;
#    }

}

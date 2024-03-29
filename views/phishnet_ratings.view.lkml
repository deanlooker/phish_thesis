view: phishnet_ratings {
  sql_table_name: dean_looker_phish_thesis.phishnet_ratings ;;

  dimension: rating {
    description: "Rating as a dimension"
    type: number
    sql: ${TABLE}.rating ;;
  }

  measure: max_rating {
    # use this when not aggregating #
    label: "Max Rating"
    description: "Rating used with MAX() to make available as measure"
    type: max
    sql: ${rating} ;;
  }

  measure: avg_rating {
    # use this when not aggregating #
    label: "Average Rating"
    description: "Average show rating"
    type: average
    sql: ${rating} ;;
  }

  dimension_group: showdate {
    type: time
    timeframes: [
      date,
      day_of_month,
      day_of_week,
      day_of_week_index,
      day_of_year,
      month,
      month_name,
      month_num,
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

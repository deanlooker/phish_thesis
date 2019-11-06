view: phishnet_venues {
  sql_table_name: dean_looker_phish_thesis.phishnet_venues ;;

  dimension: name {
    label: "Venue Name"
    description: "Venue Name according to Phish.net"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: first_played {
    type: date
    datatype: date
    sql: ${TABLE}.first_played ;;
  }

  dimension_group: first_played_group {
    description: "Date first played according to Phish.net"
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
    datatype: date
    sql: ${first_played} ;;
  }

  dimension: last_played {
    type: date
    datatype: date
    sql: ${TABLE}.last_played ;;
  }

  dimension_group: last_played_group {
    description: "Date last played according to Phish.net"
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
    datatype: date
    sql: ${last_played} ;;
  }

  dimension: times_played {
    type: number
    sql: ${TABLE}.times_played ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

view: phishin_venues {
  sql_table_name: dean_looker_phish_thesis.phishin_venues ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: coordinates {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: location {
    label: "Location"
    description: "City, State, (Country)"
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: venue_name {
    description: "Name Of Venue"
    type: string
    sql: ${TABLE}.name ;;
  }

#       ** This one is an array **
#
#   dimension: other_names {
#     type: string
#     sql: ${TABLE}.other_names ;;
#   }

  dimension_group: show_dates {
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
    sql: ${TABLE}.show_dates ;;
  }

  dimension: show_ids {
    type: number
    value_format_name: id
    # hidden: yes
    sql: ${TABLE}.show_ids ;;
  }

  dimension: shows_count {
    description: "Number of shows at the venue according to Phish.net"
    type: number
    sql: ${TABLE}.shows_count ;;
  }

  dimension: slug {
    hidden: yes
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension_group: updated {
    type: time
    hidden:  yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, venue_name, shows.showid, shows.tourname]
  }
}

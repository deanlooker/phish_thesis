view: phishin_venues {
  sql_table_name: dean_looker_phish_thesis.phishin_venues ;;

  dimension: id {
    label: "Venue ID"
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: venue_name {
    description: "Name Of Venue"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: coordinates {
    view_label: "Location"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }



  dimension: location {
    view_label: "Location"
    label: "City, State, (Country)"
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: city {
    view_label: "Location"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    view_label: "Location"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: country {
    view_label: "Location"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: latitude {
    hidden:  yes
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    hidden:  yes
    type: number
    sql: ${TABLE}.longitude ;;
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

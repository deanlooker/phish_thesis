view: phishnet_shows {
  sql_table_name: dean_looker_phish_thesis.phishnet_shows ;;

  dimension: artistid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.artistid ;;
  }

  dimension: artistlink {
    type: string
    sql: ${TABLE}.artistlink ;;
  }

  dimension: billed_as {
    type: string
    sql: ${TABLE}.billed_as ;;
  }

  dimension: link {
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: setlistnotes {
    type: string
    sql: ${TABLE}.setlistnotes ;;
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

  dimension: showid {
    type: number
    value_format_name: id
    # hidden: yes
    sql: ${TABLE}.showid ;;
  }

  dimension: tour_when {
    type: string
    sql: ${TABLE}.tour_when ;;
  }

  dimension: tourid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tourid ;;
  }

  dimension: tourname {
    type: string
    sql: ${TABLE}.tourname ;;
  }

  dimension: venue {
    type: string
    sql: ${TABLE}.venue ;;
  }

  dimension: venueid {
    type: number
    value_format_name: id
    sql: ${TABLE}.venueid ;;
  }

  measure: count {
    type: count
    drill_fields: [tourname, shows.showid, shows.tourname]
  }
}

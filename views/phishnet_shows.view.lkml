view: phishnet_shows {
  sql_table_name: dean_looker_phish_thesis.phishnet_shows ;;



  dimension: setlist_link {
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: setlistnotes {
    label: "Setlist Notes"
    description: "Full setlist notes from Phish.net"
    type: string
    sql: ${TABLE}.setlistnotes ;;
  }

  dimension_group: show {
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

  dimension: artistid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.artistid ;;
  }

  dimension: artistlink {
    hidden:  yes
    type: string
    sql: ${TABLE}.artistlink ;;
  }

  dimension: billed_as {
    hidden:  yes
    type: string
    sql: ${TABLE}.billed_as ;;
  }
}

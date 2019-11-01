view: shows_combined {
  sql_table_name: dean_looker_phish_thesis.shows_combined ;;

  dimension: show_number {
    type: number
    sql: ${TABLE}.show_number ;;
  }

# from phish.net #

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

  # from phish.in #

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: duration_seconds {
    hidden: yes
    type: number
    label: "Duration Seconds"
    sql: cast((${TABLE}.duration/1000)AS INT64) ;;
  }

  dimension: is_incomplete {
    type: yesno
    sql: ${TABLE}.incomplete ;;
  }

  dimension: is_sbd {
    type: yesno
    sql: ${TABLE}.sbd ;;
  }

  dimension: is_rmstr {
    type: yesno
    sql: ${TABLE}.remastered ;;
  }

  dimension: tour_id {
    type: number
    sql: ${TABLE}.tour_id ;;
  }

  dimension: venue_name {
    type: string
    sql: ${TABLE}.venue_name ;;
  }

  dimension: taper_notes {
    type: string
    sql: ${TABLE}.taper_notes ;;
  }

  dimension: likes_count {
    type: number
    sql: ${TABLE}.likes_count ;;
  }

  dimension_group: updated_at {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.updated_at ;;
  }

}

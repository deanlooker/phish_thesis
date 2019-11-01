view: phishin_shows_compact {
  sql_table_name: dean_looker_phish_thesis.phishin_shows_compact ;;

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

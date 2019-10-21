view: phishin_tracks {
  sql_table_name: dean_looker_phish_thesis.phishin_tracks ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: duration {
    hidden: yes
    type: number
    sql: ${TABLE}.duration/1000 ;;
  }

  dimension: duration_minutes_seconds {
    label: "Song Duration"
    type: number
    sql: ${duration}/86400.0 ;;
    value_format: "hh:mm:ss"
    description: "Length of the song"
  }

  dimension: likes_count {
    type: number
    sql: ${TABLE}.likes_count ;;
  }

  dimension: mp3 {
    label: "mp3 Audio URL"
    type: string
    sql: ${TABLE}.mp3 ;;
  }

  dimension: position {
    type: number
    sql: ${TABLE}.position ;;
  }

  dimension: set {
    hidden: yes
    type: string
    sql: ${TABLE}.set ;;
  }

  dimension: set_name {
    type: string
    sql: ${TABLE}.set_name ;;
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
    sql: ${TABLE}.show_date ;;
  }

  dimension: show_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.show_id ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: song_ids {
    type: number
    value_format_name: id
    sql: ${TABLE}.song_ids ;;
  }

  dimension: tags {
    hidden: yes
    sql: ${TABLE}.tags ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: [id, set_name]
  }
}

view: phishin_tracks__tags {
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: color {
    type: string
    sql: ${TABLE}.color ;;
  }

  dimension: group {
    type: string
    sql: ${TABLE}.group ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: priority {
    type: number
    sql: ${TABLE}.priority ;;
  }

  dimension: transcript {
    type: string
    sql: ${TABLE}.transcript ;;
  }
}

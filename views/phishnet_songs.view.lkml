view: phishnet_songs {
  sql_table_name: dean_looker_phish_thesis.phishnet_songs ;;

  dimension: alias_of {
    type: string
    sql: ${TABLE}.alias_of ;;
  }

  dimension_group: debut {
    label: "Debut Date"
    description: "Date first played"
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
    sql: ${TABLE}.debut ;;
  }

  dimension: gap {
    description: "# of shows since last played"
    type: number
    sql: ${TABLE}.gap ;;
  }

  dimension_group: last {
    label: "Last Played Date"
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
    sql: ${TABLE}.last ;;
  }

  dimension: originalartist {
    label: "Original Artist"
    description: "Artist who wrote the song"
    type: string
    sql: ${TABLE}.originalartist ;;
  }

  dimension: is_original {
    label: "Original?"
    description: "Is the song written by Phish"
    type: yesno
    sql: ${originalartist} = "Phish";;
  }

  dimension: times {
    label: "Times Played"
    type: number
    sql: ${TABLE}.times ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

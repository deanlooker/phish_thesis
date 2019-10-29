view: phishin_tracks {
  sql_table_name: dean_looker_phish_thesis.phishin_tracks ;;

  dimension: id {
    label: "Track ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: title {
    label: "Track Title"
    description: "Track Title on Phish.in"
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: duration {
    label: "Track Duration"
    sql: format_timestamp("%M:%S", timestamp_seconds(cast((${TABLE}.duration/1000)AS INT64)));;
    description: "Length of the song in MM:SS"
  }

  dimension: position {
    label: "Position in show"
    description: "Used to order setlists"
    type: number
    sql: ${TABLE}.position ;;
  }

  dimension: set_name {
    label: "Set"
    description: "Which set of the show the song was played in"
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
    hidden: yes
    sql: ${TABLE}.show_id ;;
  }

  dimension: mp3 {
    label: "Audio URL"
    description: "Link to audio on phish.in"
    type: string
    sql: ${TABLE}.mp3 ;;
  }

  measure: count {
    type: count
    drill_fields: [id, set_name]
  }

  # HIDDEN FIELDS #

  dimension: slug {
    hidden: yes
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: tags {
    # placeholder for unnesting tags in another view
    hidden: yes
    sql: ${TABLE}.tags ;;
  }

  dimension: set {
    hidden:  yes
    type: string
    sql: ${TABLE}.set ;;
  }


#   dimension: likes_count {
#     description: "Amount of phish.in users who have 'liked' the song"
#     hidden: yes
#     type: number
#     sql: ${TABLE}.likes_count ;;
#   }

#   dimension: songids {
#     sql: ${TABLE}.song_ids ;;
#   }

}

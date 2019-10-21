view: phishin_tracks {
  sql_table_name: dean_looker_phish_thesis.phishin_tracks ;;
  drill_fields: [id]

  dimension: id {
    label: "Track ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: duration {
    description: "Duration (in seconds)"
    hidden: yes
    type: number
    sql: ${TABLE}.duration/1000 ;;
  }

  dimension: duration_minutes_seconds {
    label: "Track Duration"
    type: number
    sql: ${duration}/86400.0 ;;
    value_format: "hh:mm:ss"
    description: "Length of the song"
  }

  dimension: likes_count {
    description: "Amount of phish.in users who have 'liked' the song"
    hidden: yes
    type: number
    sql: ${TABLE}.likes_count ;;
  }

  dimension: mp3 {
    label: "Audio URL"
    description: "Link to audio on phish.in"
    type: string
    sql: ${TABLE}.mp3 ;;
  }

  dimension: position {
    label: "Position in set"
    description: "Used to order setlists"
    type: number
    sql: ${TABLE}.position ;;
  }

  dimension: set {
    hidden: yes
    type: string
    sql: ${TABLE}.set ;;
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

  # html: {% if phishin_tracks__tags.name == "Jamcharts" %} {{value}}} ;;
  }

  dimension: show_id {
    type: number
    hidden: yes
    sql: ${TABLE}.show_id ;;
  }

  dimension: slug {
    hidden: yes
    type: string
    sql: ${TABLE}.slug ;;
  }

# need to figure out how to iterate through array to match "Tweezer > etc > Tweezer" types
  dimension: track_song_ids {
    type: number
    sql: ${TABLE}.song_ids ;;
  }

  dimension: tags {
    hidden: yes
    sql: ${TABLE}.tags ;;
  }

  dimension: title {
    label: "Track Title"
    description: "Track Title on Phish.in"
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
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: color {
    hidden: yes
    type: string
    sql: ${TABLE}.color ;;
  }

  dimension: group {
    hidden: yes
    label: "Tag Group"
    type: string
    sql: ${TABLE}.group ;;
  }

  dimension: name {
    label: "Tag"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notes {
    label: "Track Notes"
    description: "Displays important information about this particular version of the song - jam styles, teases, segues, etc. "
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: priority {
    hidden: yes
    type: number
    sql: ${TABLE}.priority ;;
  }

  dimension: transcript {
    label: "Narration/Banter Transcript"
    type: string
    sql: ${TABLE}.transcript ;;
  }

  dimension: starts_at_second {
    hidden: yes
    label: "Tagged Event Start Time"
    description: "Beginning timestamp of tease/narration/etc"
    type: number
    sql: ${TABLE}.starts_at_second/86400.0 ;;
    value_format: "hh:mm:ss"
  }

  dimension: ends_at_second {
    hidden:  yes
    label: "Tagged Event End Time"
    description: "End timestamp of tease/narration/etc"
    type: number
    sql: ${TABLE}.ends_at_second/86400.0 ;;
    value_format: "hh:mm:ss"
  }

  dimension: jamcharts_notes {
    sql: case when ${name} = "Jamcharts" then regexp_replace(${notes},"&gt;",">") else null end ;;
  }

  dimension: jamcharts_yesno {
    sql: ${jamcharts_notes} IS NOT NULL ;;
  }


}

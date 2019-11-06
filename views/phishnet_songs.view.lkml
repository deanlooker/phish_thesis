view: phishnet_songs {
  view_label: "Songs"
  derived_table: {
    sql: SELECT
        song.title as title,
        track.song_ids[OFFSET(0)] as song_id,
        song.originalartist as originalartist,
        song.times as times,
        song.debut as debut,
        song.last as last,
        song.gap as gap
      FROM
        dean_looker_phish_thesis.phishin_tracks as track
      JOIN
        dean_looker_phish_thesis.phishnet_songs as song
      ON
        track.title = song.title
      group by title, song_id, originalartist, times, debut, last, gap
      order by title asc
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: title {
    label: "Song Title"
    description: "Title of the Song"
    type: string
    sql: ${TABLE}.title ;;
    link: {
      label: "🎶 Song Dashboard"
      url: "/dashboards/459?Song%20Name={{ value }}"
    }
  }

  dimension: song_id {
    label: "Song ID"
    description: "Used to identify songs in Phish.In Tracks"
    type: number
    sql: ${TABLE}.song_id ;;
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
    description: "Times played according to Phish.net"
    type: number
    sql: ${TABLE}.times ;;
  }

  dimension_group: debut_group {
    description: "Date first played according to Phish.net"
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
    datatype: date
    sql: ${debut_date} ;;
  }

  dimension: debut_date {
    datatype: date
    type: date
    sql: ${TABLE}.debut} ;;
    link: {
      label: "🎫 Show Dashboard"
      url: "/dashboards/465?Show%20Date={{ value }}"
    }
  }

  dimension_group: last_played_group {
    description: "Date last played according to Phish.net"
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
    datatype: date
    sql: ${last_played} ;;
  }

  dimension: last_played {
    type: date
    datatype: date
    sql: ${TABLE}.last ;;
    link: {
      label: "🎫 Show Dashboard"
      url: "/dashboards/465?Show%20Date={{ value }}"
    }
  }

  dimension: gap {
    description: "# of shows since last played"
    type: number
    sql: ${TABLE}.gap ;;
  }

  set: detail {
    fields: [
      title,
      song_id,
      originalartist,
      times,
      debut_date,
      last_played,
      gap
    ]
  }

  measure: songs {
    description: "Songs included in track"
    type: list
    list_field: title
  }
}

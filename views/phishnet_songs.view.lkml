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

  dimension: debut {
    label: "Debut Date"
    description: "Date first played according to Phish.net"
    type: date
    sql: ${TABLE}.debut ;;
  }

  dimension: last {
    label: "Last Played Date"
    description: "Date last played according to Phish.net"
    type: date
    sql: ${TABLE}.last ;;
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
      debut,
      last,
      gap
    ]
  }
}

view: track_songids {
  derived_table: {
    sql:  SELECT id as track_id, song_id
          FROM dean_looker_phish_thesis.phishin_tracks
          JOIN UNNEST(song_ids) as song_id ;;
  }

  dimension: track_id {
    hidden: yes
  }

  dimension: song_id {
    hidden: yes
  }

  measure: track_song_list {
    type: list
    list_field: song_id
  }

}

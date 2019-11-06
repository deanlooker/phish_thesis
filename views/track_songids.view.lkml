view: track_songids {
  derived_table: {
    sql:  SELECT id as track_id, song_id
          FROM dean_looker_phish_thesis.phishin_tracks
          JOIN UNNEST(song_ids) as song_id ;;
  }

  dimension: tracksong {
    primary_key: yes
    type: string
    sql: concat(cast(${track_songids.track_id} as string), "_", cast(${track_songids.song_id} as string)) ;;
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

  measure: tracks_song_count {
    label: "Tracks: Song Count"
    description: "For phish.in tracks that include multiple songs that are segued - counts distinct combinations of Track id and Song id"
    # example: 10/30/10 "Tweezer > Heartbreaker > Tweezer > Ramble On > Thank You > Tweezer > Stairway To Heaven" counts 5 distinct songs in this track #
    type: count
  }

}

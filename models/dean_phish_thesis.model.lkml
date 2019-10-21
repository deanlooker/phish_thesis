connection: "dean_phish_data"

include: "/**/**/*.view"       # include all the views


explore: phishin_tracks {
  label: "Tracks"
  join: phishin_tracks__tags {
     view_label: "Tracks: Tags"
     sql: LEFT JOIN UNNEST(${phishin_tracks.tags}) as phishin_tracks__tags ;;
     relationship: one_to_many
  }
  join: phishnet_shows {
    view_label: "Shows"
    sql_on: ${phishin_tracks.show_date}=${phishnet_shows.showdate_date};;
    relationship: many_to_one
  }
}

explore: phishin_venues {
  join: phishnet_shows {
    type: left_outer
    sql_on: ${phishin_venues.id} = ${phishnet_shows.venueid} ;;
    relationship: one_to_many
  }
}

explore: phishnet_ratings {

}

explore: phishnet_shows {

}

explore: phishnet_songs {
  sql_always_where: ${alias_of} IS NULL ;;
  join: phishin_tracks {
    view_label: "Tracks"
    sql_on: ${phishnet_songs.title} = ${phishin_tracks.title} ;;
    relationship: one_to_many
  }
}

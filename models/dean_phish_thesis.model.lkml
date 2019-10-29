connection: "dean_phish_data"

include: "/**/**/*.view"       # include all the views

datagroup: weekly {
  max_cache_age: "168 hours"
  sql_trigger: SELECT max(showid) FROM dean_looker_phish_thesis.phishnet_shows ;;
}

explore: phishin_tracks {
  label: "Live Song Versions"
  view_label: "Live Song Versions"
  join: phishin_tracks_tags {
    view_label: "Live Song Versions"
    sql: LEFT JOIN UNNEST(${phishin_tracks.tags}) as phishin_tracks_tags ;;
    relationship: one_to_many
  }
  join: phishnet_songs {
    view_label: "Songs"
  }
  join: track_songids {
    view_label: "Live Song Versions"
    sql_on: ${track_songids.track_id} = ${phishin_tracks.id} ;;
    relationship:  one_to_many
  }
}

# explore: phishin_tracks {
#   label: "Tracks"
#   join: phishin_tracks_tags {
#     view_label: "Tracks: Tags"
#     sql_on: ${phishin_tracks.id} = ${phishin_tracks_tags.track_id} ;;
#     relationship: one_to_many
#   }
#   join: phishnet_shows {
#     view_label: "Shows"
#     sql_on: ${phishin_tracks.show_date}=${phishnet_shows.showdate_date};;
#     relationship: many_to_one
#   }
#   join: phishnet_songs {
#     view_label: "Songs"
#     sql_on: ${phishin_tracks.title} = ${phishnet_songs.title} ;;
#     relationship: many_to_one
#   }
# }

explore: phishin_venues {
  label: "Phish Venues"
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
  label: "Songs"
  join: phishin_tracks {
    view_label: "Tracks"
    sql_on: ${phishnet_songs.title} = ${phishin_tracks.title} ;;
    relationship: one_to_many
  }
#   join: phishin_tracks_tags {
#     view_label: "Tracks: Tags"
#     sql_on: ${phishin_tracks.id} = ${phishin_tracks_tags.track_id} ;;
#     relationship: one_to_many
#   }
  join: phishnet_shows {
    view_label: "Shows"
    sql_on: ${phishin_tracks.show_date}=${phishnet_shows.show_date};;
    relationship: many_to_one
  }
}

# explore: phishin_tracks_tags {}

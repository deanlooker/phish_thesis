view: phishin_tracks {
  sql_table_name: dean_looker_phish_thesis.phishin_tracks ;;



  dimension: id {
    label: "Track ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# title of the track from phish.in - some tracks include multiple songs segued together #
  dimension: title {
    label: "Track Title"
    description: "Track Title on Phish.in"
    type: string
    sql: ${TABLE}.title ;;
    html: {% if phishin_tracks_tags.jamcharts_notes_list._rendered_value != null %}
            🔥 {{linked_value}}
          {% else %}
            {{linked_value}}
          {% endif %} ;;
    #drill_fields: [track_details*]
      link: {
        label: "🎶 Song Dashboard"
        url: "/dashboards/459?Song%20Name={{ value }}"
      }
      link: {
        label: "📓 Show Details"
        url: "/explore/dean_phish_thesis/phishin_tracks?fields=phishin_tracks.position,phishin_tracks.set_name,phishin_tracks.title,phishin_tracks.duration,phishin_tracks.id,phishin_tracks_tags.tease_list,phishin_tracks_tags.jamcharts_notes_list,phishnet_songs.songs&f[phishin_tracks.show_date]={{ _filters['phishin_tracks.show_date'] | url_encode }}&sorts=phishin_tracks.position&limit=500&column_limit=50&dynamic_fields=%5B%5D&query_timezone=America%2FLos_Angeles&origin=drill-menu"
      }
  }

  set: track_details {
    fields: [title, song_duration_sum, phishin_tracks_tags.teases_list, phishin_tracks_tags.jamcharts_notes_list]
  }

# durations in the db are stored in ms, this is converted #
  dimension: duration_seconds {
    hidden: yes
    type: number
    label: "Duration Seconds"
    sql: cast((${TABLE}.duration/1000)AS INT64) ;;
  }


# This sum aggregates song duration by date, so for dates where the same song is played and then reprised, the duration of the two tracks is aggregated as a sum #
  measure: song_duration_sum {
    label: "Jam Duration"
    description: "Duration of song"
    type: sum
    sql: ${duration_seconds}/86400 ;;
    value_format: "[h]:mm:ss"
    html: {% if phishin_tracks_tags.jamcharts_notes_list._rendered_value != null %}
          {{ rendered_value }} <br>
          Jam Notes: {{ phishin_tracks_tags.jamcharts_notes_list._rendered_value }}
          {% else %}
          {{ rendered_value }}
          {% endif %};;
  }

# this dimension is used for indivudual tracks, so reprised songs are counted separately. #
  dimension: duration {
    label: "Track Duration"
    type: string
    sql: format_timestamp("%M:%S", timestamp_seconds(${duration_seconds}));;
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

  dimension_group: show_group {
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
    convert_tz: no
    datatype: date
    sql: ${show_date} ;;
  }

  dimension: show_date {
    type: date
    datatype: date
    sql: ${TABLE}.show_date ;;
  }

  measure: last_played {
    type: date
    sql: max(${show_date}) ;;
  }

  measure: first_played {
    type: date
    sql: min(${show_date}) ;;
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

  measure: track_count {
    description: "Count of tracks in the show on phish.in"
    type: count
    drill_fields: [track_details*]
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

  dimension: jamcharts_yesno {
  type: yesno
  sql: EXISTS (SELECT 1 from unnest(tags) where name = "Jamcharts") ;;
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

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

  measure: last_played {
    type: date
    sql: max(${show_raw}) ;;
  }

  measure: first_played {
    type: date
    sql: min(${show_raw}) ;;
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

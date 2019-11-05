view: shows_combined {
  sql_table_name: dean_looker_phish_thesis.shows_combined ;;

  dimension: show_number {
    type: number
    sql: ${TABLE}.show_number ;;
  }

# from phish.net #

  dimension: phishnet_link {
    view_label: "Phish.net Shows"
    label: "Phish.net Link"
    description: "Link to the official show page on Phish.net"
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: location {
    view_label: "Phish.net Shows"
    description: "City, State, [Country] where the show was played"
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: setlistnotes {
    view_label: "Phish.net Shows"
    label: "Setlist Notes"
    description: "Full setlist notes from Phish.net"
    type: string
    sql: ${TABLE}.setlistnotes ;;
  }

  dimension_group: show {
    view_label: "Phish.net Shows"
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
    sql: ${TABLE}.showdate ;;
  }

  dimension: showid {
    view_label: "Phish.net Shows"
    type: number
    # hidden: yes
    sql: ${TABLE}.showid ;;
  }

  dimension: tour_when {
    view_label: "Phish.net Shows"
    type: string
    sql: ${TABLE}.tour_when ;;
  }

  dimension: tourid {
    view_label: "Phish.net Shows"
    type: number
    value_format_name: id
    sql: ${TABLE}.tourid ;;
  }

  dimension: tourname {
    view_label: "Phish.net Shows"
    type: string
    sql: ${TABLE}.tourname ;;
  }

  dimension: venue {
    view_label: "Phish.net Shows"
    type: string
    sql: ${TABLE}.venue ;;
  }

  dimension: venueid {
    view_label: "Phish.net Shows"
    type: number
    value_format_name: id
    sql: ${TABLE}.venueid ;;
  }

  measure: count {
    view_label: "Phish.net Shows"
    type: count
    drill_fields: [tourname, shows.showid, shows.tourname]
  }

  # dimension: artistid {
  #   view_label: "Phish.net Shows"
  #   hidden: yes
  #   type: number
  #   value_format_name: id
  #   sql: ${TABLE}.artistid ;;
  # }

  # dimension: artistlink {
  #   view_label: "Phish.net Shows"
  #   hidden:  yes
  #   type: string
  #   sql: ${TABLE}.artistlink ;;
  # }

  # dimension: billed_as {
  #   view_label: "Phish.net Shows"
  #   hidden:  yes
  #   type: string
  #   sql: ${TABLE}.billed_as ;;
  # }




  # from phish.in #

  dimension: id {
    view_label: "Phish.in Shows"
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: date {
    view_label: "Phish.in Shows"
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
    sql: ${TABLE}.date ;;
  }

  dimension: duration_seconds {
    view_label: "Phish.in Shows"
    hidden: yes
    type: number
    label: "Duration Seconds"
    sql: cast((${TABLE}.duration/1000)AS INT64) ;;
  }

  dimension: is_incomplete {
    view_label: "Phish.in Shows"
    label: "Is Incomplete? (Yes/No)"
    description: "Shows whether or not the audio for the show is incomplete"
    type: yesno
    sql: ${TABLE}.incomplete ;;
  }

  dimension: is_sbd {
    view_label: "Phish.in Shows"
    label: "Is Soundboard? (Yes/No)"
    description: "Shows whether or not the audio for the show is a soundboard recording"
    type: yesno
    sql: ${TABLE}.sbd ;;
  }

  dimension: is_rmstr {
    view_label: "Phish.in Shows"
    label: "Is Remastered? (Yes/No)"
    description: "Shows whether or not the audio for the show has been remastered"
    type: yesno
    sql: ${TABLE}.remastered ;;
  }

  dimension: tour_id {
    view_label: "Phish.in Shows"
    type: number
    sql: ${TABLE}.tour_id ;;
  }

  dimension: venue_name {
    view_label: "Phish.in Shows"
    type: string
    sql: ${TABLE}.venue_name ;;
  }

  dimension: taper_notes {
    view_label: "Phish.in Shows"
    type: string
    sql: ${TABLE}.taper_notes ;;
  }

  # dimension: likes_count {
  #   view_label: "Phish.in Shows"
  #   type: number
  #   sql: ${TABLE}.likes_count ;;
  # }

  # dimension_group: updated_at {
  #   view_label: "Phish.in Shows"
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   convert_tz: no
  #   datatype: timestamp
  #   sql: ${TABLE}.updated_at ;;
  # }

}

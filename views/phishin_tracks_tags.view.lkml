# This table contains individual rows for each tag applied to each track on phish.in

view: phishin_tracks_tags {
  dimension: unique_id {
    group_label: "Tags"
    group_item_label: "Unique ID"
    description: "Used to uniquely identify a specific tag from a specific track"
    primary_key: yes
    #sql: CONCAT(CAST(${phishin_tracks.id} AS STRING),'|', ${name}, '|', case when ${notes} is not null then ${notes} else "" end) ;;
    sql: CONCAT(CAST(phishin_tracks.id AS STRING),'|', tags.name, '|',
case when tags.notes is not null and tags.starts_at_second is not null then concat(tags.notes, cast(tags.starts_at_second as string)) when tags.notes is not null then tags.notes else null end) ;;
  }

  dimension: id {
    hidden: yes
    type: number
  }

  dimension: name {
    group_label: "Tags"
    group_item_label: "Tag Type"
    type: string
  }

  dimension: notes_fixed {
    group_label: "Tags"
    group_item_label: "Notes"
    description: "Information about this particular performance of the song"
    type: string
    sql: regexp_replace(${notes},"&gt;",">") ;;
  }

  dimension: transcript {
    group_label: "Tags"
    group_item_label: "Narration Transcript"
    description: "Used to transcribe narration and banter in live performances of the song"
    type: string
  }

  dimension: teases {
    hidden: yes
    type: string
    sql: case when ${name} = "Tease" then ${notes} else null end ;;
  }

  measure: tease_list {
    label: "Tags: Teases List"
    description: "List of other songs teased in this version of the song"
    type: list
    list_field: teases
  }

  dimension: jamcharts_notes {
    hidden: yes
    type: string
    sql: case when ${name} = "Jamcharts" then ${notes_fixed} else null end ;;
  }

  measure: jamcharts_notes_list {
    label: "Tags: Jamcharts Notes"
    description: "Notes from Phish.net Jamcharts for notable versions of a song"
    type: list
    list_field: jamcharts_notes
  }


  dimension: notes {
    label: "Notes escaped"
    hidden: yes
    type: string
  }

  dimension: starts_at_second {
    hidden: yes
    type: number
  }

  dimension: ends_at_second {
    hidden: yes
    type: number
  }

}

# view: phishin_tracks_tags {
#   derived_table: {
#     datagroup_trigger: weekly
#     sql:SELECT
#           row_number() OVER() track_tag_id, track_id, show_date, tag_id, tag_type, tag_group, starts_at_second, ends_at_second, notes, transcript
#         FROM
#           (SELECT
#             phishin_tracks.id as track_id,
#             phishin_tracks.show_date as show_date,
#             tags.id as tag_id,
#             tags.name as tag_type,
#             tags.group as tag_group,
#             tags.starts_at_second as starts_at_second,
#             tags.ends_at_second as ends_at_second,
#             tags.notes as notes,
#             tags.transcript as transcript
#           FROM
#             dean_looker_phish_thesis.phishin_tracks
#           JOIN
#           UNNEST(tags) AS tags
#           ORDER by 1);;
#   }
#   drill_fields: [tag_id]
#
#   dimension: track_tag_id {
#     type: number
#     primary_key: yes
#     sql: ${TABLE}.track_tag_id ;;
#   }
#
#   dimension: track_id {
#     type: number
#     sql: ${TABLE}.track_id;;
#   }
#
#   dimension: show_date {
#     type: date
#     sql: ${TABLE}.show_date ;;
#   }
#
#   dimension: tag_id {
#     hidden: yes
#     type: number
#     sql: ${TABLE}.tag_id ;;
#   }
#
#   dimension: tag_type {
#     label: "Tag Type"
#     type: string
#     sql: ${TABLE}.tag_type ;;
#   }
#
#   dimension: tag_group {
#     hidden: yes
#     type: string
#     sql: ${TABLE}.tag_group ;;
#   }
#
#
#   dimension: notes {
#     label: "Track Notes"
#     description: "Displays important information about this particular version of the song - jam styles, teases, segues, etc. "
#     type: string
#     sql: ${TABLE}.notes ;;
#   }
#
#   dimension: transcript {
#     label: "Narration/Banter Transcript"
#     type: string
#     sql: ${TABLE}.transcript ;;
#   }
#
#   dimension: starts_at_second {
#     hidden: yes
#     label: "Tagged Event Start Time"
#     description: "Beginning timestamp of tease/narration/etc"
#     type: number
#     sql: ${TABLE}.starts_at_second/86400.0 ;;
#     value_format: "hh:mm:ss"
#   }
#
#   dimension: ends_at_second {
#     hidden:  yes
#     label: "Tagged Event End Time"
#     description: "End timestamp of tease/narration/etc"
#     type: number
#     sql: ${TABLE}.ends_at_second/86400.0 ;;
#     value_format: "hh:mm:ss"
#   }
#
#   dimension: jamcharts_notes {
#     sql: case when ${tag_type} = "Jamcharts" then regexp_replace(${notes},"&gt;",">") else null end ;;
#   }
#
#   dimension: teases {
#     sql: case when ${tag_type} = "Tease" then ${notes} else null end ;;
#   }
#

#
#   dimension: is_debut {
#
#   }
#
#
#
# }

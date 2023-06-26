project_name: "dean_looker_phish_thesis"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
application: data-dictionary-dev {
  label: "Data Dictionary (dev)"
  url: "http://localhost:8080/bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    core_api_methods: ["run_inline_query", "lookml_model_explore", "all_lookml_models", "all_users", "me", "search_groups"]
  }
}

# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200825171721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "tablefunc"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "api_clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "app_token",  limit: 255
    t.string   "app_secret", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_access_token_request_objects", force: :cascade do |t|
    t.integer  "access_token_id"
    t.integer  "request_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_access_token_scopes", force: :cascade do |t|
    t.integer  "access_token_id"
    t.integer  "scope_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_access_tokens", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "client_id"
    t.string   "token",      limit: 255
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connect_access_tokens", ["token"], name: "index_connect_access_tokens_on_token", unique: true, using: :btree

  create_table "connect_authorization_request_objects", force: :cascade do |t|
    t.integer  "authorization_id"
    t.integer  "request_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_authorization_scopes", force: :cascade do |t|
    t.integer  "authorization_id"
    t.integer  "scope_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_authorizations", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "client_id"
    t.string   "code",         limit: 255
    t.string   "nonce",        limit: 255
    t.string   "redirect_uri", limit: 255
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connect_authorizations", ["code"], name: "index_connect_authorizations_on_code", unique: true, using: :btree

  create_table "connect_clients", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "identifier",          limit: 255
    t.string   "secret",              limit: 255
    t.string   "name",                limit: 255
    t.string   "jwks_uri",            limit: 255
    t.string   "sector_identifier",   limit: 255
    t.string   "redirect_uris",       limit: 255
    t.boolean  "dynamic",                         default: false
    t.boolean  "native",                          default: false
    t.boolean  "ppid",                            default: false
    t.boolean  "superapp",                        default: false
    t.datetime "expires_at"
    t.text     "raw_registered_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connect_clients", ["identifier"], name: "index_connect_clients_on_identifier", unique: true, using: :btree

  create_table "connect_grants", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "account_id"
    t.integer  "scope_id"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connect_grants", ["account_id"], name: "index_connect_grants_on_account_id", using: :btree
  add_index "connect_grants", ["client_id"], name: "index_connect_grants_on_client_id", using: :btree
  add_index "connect_grants", ["scope_id"], name: "index_connect_grants_on_scope_id", using: :btree

  create_table "connect_id_token_request_objects", force: :cascade do |t|
    t.integer  "id_token_id"
    t.integer  "request_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_id_tokens", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "client_id"
    t.string   "nonce",      limit: 255
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_pairwise_pseudonymous_identifiers", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "identifier",        limit: 255
    t.string   "sector_identifier", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_request_objects", force: :cascade do |t|
    t.text     "jwt_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_scopes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connect_scopes", ["name"], name: "index_connect_scopes_on_name", unique: true, using: :btree

  create_table "data_filters", force: :cascade do |t|
    t.string   "model",       limit: 255
    t.string   "field",       limit: 255
    t.string   "pattern_raw", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "homepage_link_roles", force: :cascade do |t|
    t.integer "homepage_link_id"
    t.string  "role_scope",       limit: 255
  end

  create_table "homepage_links", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",              limit: 255
    t.text     "description"
    t.string   "icon",              limit: 255
    t.string   "url",               limit: 255
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "ordinal"
    t.string   "group",             limit: 255
    t.integer  "group_ordinal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "homepage_links", ["region_id"], name: "index_homepage_links_on_region_id", using: :btree

  create_table "incidents_attachments", force: :cascade do |t|
    t.integer  "incident_id",                   null: false
    t.string   "attachment_type",   limit: 255
    t.string   "name",              limit: 255
    t.text     "description"
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "incidents_attachments", ["incident_id"], name: "index_incidents_attachments_on_incident_id", using: :btree

  create_table "incidents_call_logs", force: :cascade do |t|
    t.integer  "region_id"
    t.integer  "dispatching_region_id"
    t.string   "call_type",             limit: 255
    t.string   "contact_name",          limit: 255
    t.string   "contact_number",        limit: 255
    t.string   "address_entry",         limit: 255
    t.string   "address",               limit: 255
    t.string   "city",                  limit: 255
    t.string   "state",                 limit: 255
    t.string   "zip",                   limit: 255
    t.string   "county",                limit: 255
    t.float    "lat"
    t.float    "lng"
    t.string   "incident_type",         limit: 255
    t.text     "services_requested"
    t.integer  "num_displaced"
    t.text     "referral_reason"
    t.datetime "call_start"
    t.integer  "incident_id"
    t.integer  "response_territory_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_call_logs", ["dispatching_region_id"], name: "index_incidents_call_logs_on_dispatching_region_id", using: :btree
  add_index "incidents_call_logs", ["region_id"], name: "index_incidents_call_logs_on_region_id", using: :btree

  create_table "incidents_cas_cases", force: :cascade do |t|
    t.integer  "cas_incident_id"
    t.string   "case_number",         limit: 255
    t.integer  "num_clients"
    t.string   "family_name",         limit: 255
    t.date     "case_last_updated"
    t.date     "case_opened"
    t.boolean  "case_is_open"
    t.string   "language",            limit: 255
    t.text     "narrative"
    t.string   "address",             limit: 255
    t.string   "city",                limit: 255
    t.string   "state",               limit: 255
    t.string   "post_incident_plans", limit: 255
    t.text     "notes"
    t.datetime "last_import"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
  end

  add_index "incidents_cas_cases", ["cas_incident_id"], name: "index_incidents_cas_cases_on_cas_incident_id", using: :btree
  add_index "incidents_cas_cases", ["case_number"], name: "index_incidents_cas_cases_on_case_number", unique: true, using: :btree

  create_table "incidents_cas_incidents", force: :cascade do |t|
    t.string   "dr_number",                 limit: 255
    t.string   "cas_incident_number",       limit: 255
    t.string   "cas_name",                  limit: 255
    t.integer  "dr_level"
    t.boolean  "is_dr"
    t.string   "county",                    limit: 255
    t.integer  "cases_opened"
    t.integer  "cases_open"
    t.integer  "cases_closed"
    t.integer  "cases_with_assistance"
    t.integer  "cases_service_only"
    t.integer  "num_clients"
    t.integer  "phantom_cases"
    t.date     "last_date_with_open_cases"
    t.date     "incident_date"
    t.text     "notes"
    t.datetime "last_import"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "region_id"
    t.string   "region_code",               limit: 255
    t.boolean  "ignore_incident",                       default: false, null: false
  end

  add_index "incidents_cas_incidents", ["cas_incident_number"], name: "index_incidents_cas_incidents_on_cas_incident_number", unique: true, using: :btree

  create_table "incidents_case_assistance_items", force: :cascade do |t|
    t.integer  "price_list_item_id"
    t.integer  "case_id"
    t.integer  "quantity"
    t.decimal  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_case_assistance_items", ["case_id"], name: "index_incidents_case_assistance_items_on_case_id", using: :btree
  add_index "incidents_case_assistance_items", ["price_list_item_id"], name: "index_incidents_case_assistance_items_on_price_list_item_id", using: :btree

  create_table "incidents_cases", force: :cascade do |t|
    t.integer  "incident_id"
    t.string   "cas_case_number", limit: 255
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "address",         limit: 255
    t.string   "unit",            limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.string   "zip",             limit: 255
    t.float    "lat"
    t.float    "lng"
    t.string   "phone_number",    limit: 255
    t.integer  "num_adults"
    t.integer  "num_children"
    t.decimal  "total_amount"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cac_masked",      limit: 255
  end

  add_index "incidents_cases", ["incident_id"], name: "index_incidents_cases_on_incident_id", using: :btree

  create_table "incidents_dat_incidents", force: :cascade do |t|
    t.integer  "incident_id",                         null: false
    t.string   "incident_call_type",      limit: 255
    t.string   "verified_by",             limit: 255
    t.integer  "num_people_injured"
    t.integer  "num_people_hospitalized"
    t.integer  "num_people_deceased"
    t.string   "cross_street",            limit: 255
    t.integer  "units_affected"
    t.integer  "units_minor"
    t.integer  "units_major"
    t.integer  "units_destroyed"
    t.text     "services"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "structure_type",          limit: 255
    t.integer  "completed_by_id"
    t.text     "languages"
    t.hstore   "resources"
    t.integer  "num_first_responders"
    t.boolean  "suspicious_fire"
    t.integer  "injuries_black"
    t.integer  "injuries_red"
    t.integer  "injuries_yellow"
    t.string   "where_started",           limit: 255
    t.datetime "under_control_at"
    t.string   "box",                     limit: 255
    t.datetime "box_at"
    t.string   "battalion",               limit: 255
    t.integer  "num_alarms"
    t.string   "size_up",                 limit: 255
    t.integer  "num_exposures"
    t.string   "vacate_type",             limit: 255
    t.string   "vacate_number",           limit: 255
    t.integer  "num_people_missing"
    t.string   "hazardous_materials",     limit: 255
    t.integer  "units_unknown"
  end

  add_index "incidents_dat_incidents", ["incident_id"], name: "index_incidents_dat_incidents_on_incident_id", unique: true, using: :btree

  create_table "incidents_deployments", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "gap",             limit: 255
    t.string   "group",           limit: 255
    t.string   "activity",        limit: 255
    t.string   "position",        limit: 255
    t.string   "qual",            limit: 255
    t.date     "date_first_seen"
    t.date     "date_last_seen"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "disaster_id"
  end

  create_table "incidents_disasters", force: :cascade do |t|
    t.integer  "vc_incident_id"
    t.string   "dr_number",      limit: 255
    t.integer  "fiscal_year"
    t.string   "name",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents_dispatch_log_items", force: :cascade do |t|
    t.integer  "dispatch_log_id"
    t.datetime "action_at"
    t.string   "action_type",     limit: 255
    t.string   "recipient",       limit: 255
    t.string   "operator",        limit: 255
    t.string   "result",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_dispatch_log_items", ["dispatch_log_id"], name: "index_incidents_dispatch_log_items_on_dispatch_log_id", using: :btree

  create_table "incidents_dispatch_logs", force: :cascade do |t|
    t.string   "incident_number",    limit: 255
    t.integer  "region_id"
    t.integer  "incident_id"
    t.datetime "received_at"
    t.datetime "delivered_at"
    t.string   "delivered_to",       limit: 255
    t.string   "incident_type",      limit: 255
    t.string   "address",            limit: 255
    t.string   "cross_street",       limit: 255
    t.string   "county",             limit: 255
    t.string   "displaced",          limit: 255
    t.string   "services_requested", limit: 255
    t.string   "agency",             limit: 255
    t.string   "contact_name",       limit: 255
    t.string   "contact_phone",      limit: 255
    t.string   "caller_id",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",              limit: 255
    t.string   "message_number",     limit: 255
  end

  add_index "incidents_dispatch_logs", ["incident_id"], name: "index_incidents_dispatch_logs_on_incident_id", using: :btree
  add_index "incidents_dispatch_logs", ["region_id"], name: "index_incidents_dispatch_logs_on_region_id", using: :btree

  create_table "incidents_event_logs", force: :cascade do |t|
    t.integer  "incident_id"
    t.integer  "person_id"
    t.string   "event",       limit: 255
    t.datetime "event_time"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
    t.integer  "region_id"
  end

  add_index "incidents_event_logs", ["incident_id"], name: "index_incidents_event_logs_on_incident_id", using: :btree
  add_index "incidents_event_logs", ["person_id"], name: "index_incidents_event_logs_on_person_id", using: :btree
  add_index "incidents_event_logs", ["region_id"], name: "index_incidents_event_logs_on_region_id", using: :btree

  create_table "incidents_incidents", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "incident_number",             limit: 255
    t.string   "incident_type",               limit: 255
    t.string   "cas_event_number",            limit: 255
    t.date     "date"
    t.integer  "num_adults"
    t.integer  "num_children"
    t.integer  "num_families"
    t.integer  "num_cases"
    t.string   "incident_description",        limit: 255
    t.text     "narrative_brief"
    t.text     "narrative"
    t.string   "address",                     limit: 255
    t.string   "cross_street",                limit: 255
    t.string   "neighborhood",                limit: 255
    t.string   "city",                        limit: 255
    t.string   "state",                       limit: 255
    t.string   "zip",                         limit: 255
    t.float    "lat"
    t.float    "lng"
    t.string   "idat_incident_id",            limit: 255
    t.string   "idat_incident_rev",           limit: 255
    t.datetime "last_idat_sync"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_no_incident_warning"
    t.boolean  "ignore_incident_report"
    t.boolean  "evac_partner_used",                       default: false
    t.boolean  "hotel_partner_used",                      default: false
    t.boolean  "shelter_partner_used",                    default: false
    t.boolean  "feeding_partner_used",                    default: false
    t.integer  "shift_territory_id"
    t.string   "county",                      limit: 255
    t.string   "status",                      limit: 255,                 null: false
    t.date     "response_date"
    t.integer  "notification_level_id"
    t.text     "notification_level_message"
    t.string   "recruitment_message",         limit: 255
    t.integer  "cas_event_id"
    t.boolean  "address_directly_entered",                default: false, null: false
    t.integer  "response_territory_id"
    t.integer  "current_dispatch_contact_id"
    t.datetime "dispatch_contact_due_at"
    t.string   "reason_marked_invalid"
  end

  add_index "incidents_incidents", ["cas_event_number"], name: "index_incidents_incidents_on_cas_event_number", using: :btree
  add_index "incidents_incidents", ["incident_number"], name: "index_incidents_incidents_on_incident_number", using: :btree
  add_index "incidents_incidents", ["region_id", "id", "date"], name: "index_incidents_incidents_on_region_id_id_date", using: :btree
  add_index "incidents_incidents", ["region_id", "incident_number"], name: "index_incidents_incidents_on_region_id_incident_number", unique: true, using: :btree
  add_index "incidents_incidents", ["region_id"], name: "index_incidents_incidents_on_region_id", using: :btree

  create_table "incidents_initial_incident_reports", force: :cascade do |t|
    t.integer  "incident_id"
    t.integer  "completed_by_id"
    t.integer  "approved_by_id"
    t.boolean  "budget_exceeded"
    t.string   "trend",                 limit: 255
    t.string   "triggers",              limit: 255, array: true
    t.integer  "estimated_units"
    t.integer  "estimated_individuals"
    t.string   "expected_services",     limit: 255, array: true
    t.boolean  "significant_media"
    t.boolean  "safety_concerns"
    t.boolean  "weather_concerns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_initial_incident_reports", ["approved_by_id"], name: "index_incidents_initial_incident_reports_on_approved_by_id", using: :btree
  add_index "incidents_initial_incident_reports", ["completed_by_id"], name: "index_incidents_initial_incident_reports_on_completed_by_id", using: :btree
  add_index "incidents_initial_incident_reports", ["incident_id"], name: "index_incidents_initial_incident_reports_on_incident_id", using: :btree

  create_table "incidents_notifications_events", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "event_type",  limit: 255
    t.string   "event",       limit: 255
    t.integer  "ordinal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_notifications_events", ["region_id"], name: "index_incidents_notifications_events_on_region_id", using: :btree

  create_table "incidents_notifications_role_configurations", force: :cascade do |t|
    t.integer "role_id",            null: false
    t.integer "position_id",        null: false
    t.integer "shift_territory_id"
  end

  add_index "incidents_notifications_role_configurations", ["role_id", "position_id"], name: "index_incidents_notifications_roles_roster_positions", unique: true, using: :btree

  create_table "incidents_notifications_role_scopes", force: :cascade do |t|
    t.integer  "role_id"
    t.string   "level",                 limit: 255
    t.string   "value",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "response_territory_id"
  end

  add_index "incidents_notifications_role_scopes", ["role_id"], name: "index_incidents_notifications_role_scopes_on_role_id", using: :btree

  create_table "incidents_notifications_roles", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents_notifications_roles_scheduler_shifts", id: false, force: :cascade do |t|
    t.integer "role_id",  null: false
    t.integer "shift_id", null: false
  end

  add_index "incidents_notifications_roles_scheduler_shifts", ["role_id", "shift_id"], name: "index_incidents_notifications_roles_scheduler_shifts", unique: true, using: :btree

  create_table "incidents_notifications_triggers", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "event_id"
    t.string   "template",   limit: 255
    t.boolean  "use_sms"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_notifications_triggers", ["event_id"], name: "index_incidents_notifications_triggers_on_event_id", using: :btree
  add_index "incidents_notifications_triggers", ["role_id"], name: "index_incidents_notifications_triggers_on_role_id", using: :btree

  create_table "incidents_number_sequences", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "current_year"
    t.integer "current_number"
    t.string  "format",         limit: 255
  end

  create_table "incidents_partner_uses", force: :cascade do |t|
    t.integer  "incident_id"
    t.integer  "partner_id"
    t.string   "role",         limit: 255
    t.decimal  "hotel_rate"
    t.integer  "hotel_rooms"
    t.integer  "meals_served"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_partner_uses", ["incident_id"], name: "index_incidents_partner_uses_on_incident_id", using: :btree
  add_index "incidents_partner_uses", ["partner_id"], name: "index_incidents_partner_uses_on_partner_id", using: :btree

  create_table "incidents_price_list_items", force: :cascade do |t|
    t.integer  "item_class"
    t.string   "name",        limit: 255
    t.string   "type",        limit: 255
    t.decimal  "unit_price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                 default: true, null: false
  end

  create_table "incidents_report_subscriptions", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "shift_territory_id"
    t.string   "report_type",        limit: 255
    t.boolean  "persistent",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "options"
    t.string   "frequency",          limit: 255
    t.date     "last_sent"
    t.integer  "scope_id"
  end

  add_index "incidents_report_subscriptions", ["person_id"], name: "index_incidents_report_subscriptions_on_person_id", using: :btree
  add_index "incidents_report_subscriptions", ["shift_territory_id"], name: "index_incidents_report_subscriptions_on_shift_territory_id", using: :btree

  create_table "incidents_responder_assignments", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "incident_id"
    t.string   "role",              limit: 255
    t.string   "response",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "was_flex",                      default: false
    t.float    "driving_distance"
    t.datetime "dispatched_at"
    t.datetime "on_scene_at"
    t.datetime "departed_scene_at"
  end

  add_index "incidents_responder_assignments", ["incident_id"], name: "index_incidents_responder_assignments_on_incident_id", using: :btree
  add_index "incidents_responder_assignments", ["person_id"], name: "index_incidents_responder_assignments_on_person_id", using: :btree

  create_table "incidents_responder_messages", force: :cascade do |t|
    t.integer  "region_id"
    t.integer  "person_id"
    t.integer  "incident_id"
    t.integer  "responder_assignment_id"
    t.integer  "in_reply_to_id"
    t.string   "direction",               limit: 255
    t.string   "local_number",            limit: 255
    t.string   "remote_number",           limit: 255
    t.text     "message"
    t.boolean  "acknowledged"
    t.string   "status",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_responder_messages", ["person_id"], name: "index_incidents_responder_messages_on_person_id", using: :btree
  add_index "incidents_responder_messages", ["region_id"], name: "index_incidents_responder_messages_on_region_id", using: :btree

  create_table "incidents_responder_recruitments", force: :cascade do |t|
    t.integer  "incident_id"
    t.integer  "person_id"
    t.string   "response",            limit: 255
    t.integer  "outbound_message_id"
    t.integer  "inbound_message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_responder_recruitments", ["incident_id", "person_id"], name: "index_responder_recruitments_incident_person", using: :btree

  create_table "incidents_response_territories", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",                 limit: 255
    t.boolean  "enabled"
    t.boolean  "is_default"
    t.string   "counties",             limit: 255, array: true
    t.string   "cities",               limit: 255, array: true
    t.string   "zip_codes",            limit: 255, array: true
    t.string   "dispatch_number",      limit: 255
    t.string   "non_disaster_number",  limit: 255
    t.text     "special_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dispatch_config_id"
  end

  add_index "incidents_response_territories", ["region_id"], name: "index_incidents_response_territories_on_region_id", using: :btree

  create_table "incidents_response_territories_roster_shift_territories", id: false, force: :cascade do |t|
    t.integer "response_territory_id"
    t.integer "shift_territory_id"
  end

  add_index "incidents_response_territories_roster_shift_territories", ["response_territory_id", "shift_territory_id"], name: "incidents_response_territories_roster_shift_territories_index", using: :btree

  create_table "incidents_scopes", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "url_slug",   limit: 255
    t.string   "abbrev",     limit: 255
    t.string   "short_name", limit: 255
    t.string   "name",       limit: 255
    t.hstore   "config"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_scopes", ["url_slug"], name: "index_incidents_scopes_on_url_slug", unique: true, using: :btree

  create_table "incidents_scopes_roster_regions", id: false, force: :cascade do |t|
    t.integer "scope_id",  null: false
    t.integer "region_id", null: false
  end

  add_index "incidents_scopes_roster_regions", ["scope_id", "region_id"], name: "index_incidents_scopes_roster_regions", unique: true, using: :btree

  create_table "incidents_vehicle_uses", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.integer  "incident_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incidents_vehicle_uses", ["incident_id"], name: "index_incidents_vehicle_uses_on_incident_id", using: :btree
  add_index "incidents_vehicle_uses", ["vehicle_id"], name: "index_incidents_vehicle_uses_on_vehicle_id", using: :btree

  create_table "job_logs", force: :cascade do |t|
    t.string   "controller",        limit: 255
    t.string   "name",              limit: 255
    t.string   "url",               limit: 255
    t.string   "result",            limit: 255
    t.string   "message_subject",   limit: 255
    t.string   "file_name",         limit: 255
    t.integer  "file_size"
    t.integer  "num_rows"
    t.text     "log"
    t.text     "import_errors"
    t.text     "exception"
    t.text     "exception_message"
    t.text     "exception_trace"
    t.float    "runtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tenant_id"
    t.string   "tenant_type",       limit: 255
  end

  create_table "logistics_vehicles", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",       limit: 255
    t.string   "category",   limit: 255
    t.string   "address",    limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "zip",        limit: 255
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lookups", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "scope",      limit: 255
    t.string   "name",       limit: 255, null: false
    t.string   "value",      limit: 255, null: false
    t.integer  "ordinal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lookups", ["region_id"], name: "index_lookups_on_region_id", using: :btree

  create_table "motds", force: :cascade do |t|
    t.integer  "region_id"
    t.datetime "begins"
    t.datetime "ends"
    t.string   "cookie_code",    limit: 255
    t.text     "html"
    t.string   "dialog_class",   limit: 255
    t.integer  "cookie_version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "path_regex_raw", limit: 255
  end

  add_index "motds", ["region_id"], name: "index_motds_on_region_id", using: :btree

  create_table "named_queries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "token",      limit: 255
    t.text     "parameters"
    t.string   "controller", limit: 255
    t.string   "action",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "named_queries", ["name", "token"], name: "index_named_queries_on_name_and_token", using: :btree

  create_table "partners_partners", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address1",   limit: 255
    t.string   "address2",   limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "zip",        limit: 255
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "region_id"
  end

  add_index "partners_partners", ["region_id"], name: "index_partners_partners_on_region_id", using: :btree

  create_table "roster_capabilities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "grant_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roster_capability_memberships", force: :cascade do |t|
    t.integer "capability_id"
    t.integer "position_id"
    t.string  "description",   limit: 255
  end

  create_table "roster_capability_scopes", force: :cascade do |t|
    t.string   "scope",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capability_membership_id"
  end

  create_table "roster_cell_carriers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "sms_gateway", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pager"
  end

  create_table "roster_people", force: :cascade do |t|
    t.integer  "region_id"
    t.integer  "primary_shift_territory_id"
    t.string   "first_name",                 limit: 255
    t.string   "last_name",                  limit: 255
    t.string   "email",                      limit: 255
    t.string   "secondary_email",            limit: 255
    t.string   "username",                   limit: 255
    t.string   "home_phone",                 limit: 255
    t.string   "cell_phone",                 limit: 255
    t.string   "work_phone",                 limit: 255
    t.string   "alternate_phone",            limit: 255
    t.string   "sms_phone",                  limit: 255
    t.string   "phone_1_preference",         limit: 255
    t.string   "phone_2_preference",         limit: 255
    t.string   "phone_3_preference",         limit: 255
    t.string   "phone_4_preference",         limit: 255
    t.string   "address1",                   limit: 255
    t.string   "address2",                   limit: 255
    t.string   "city",                       limit: 255
    t.string   "state",                      limit: 255
    t.string   "zip",                        limit: 255
    t.integer  "vc_id"
    t.integer  "vc_member_number"
    t.integer  "home_phone_carrier_id"
    t.integer  "work_phone_carrier_id"
    t.integer  "cell_phone_carrier_id"
    t.integer  "alternate_phone_carrier_id"
    t.integer  "sms_phone_carrier_id"
    t.boolean  "home_phone_disable"
    t.boolean  "work_phone_disable"
    t.boolean  "cell_phone_disable"
    t.boolean  "alternate_phone_disable"
    t.boolean  "sms_phone_disable"
    t.string   "encrypted_password",         limit: 255
    t.string   "password_salt",              limit: 255
    t.binary   "persistence_token"
    t.datetime "last_login"
    t.datetime "vc_imported_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "vc_is_active",                           default: true
    t.string   "gap_primary",                limit: 255
    t.string   "gap_secondary",              limit: 255
    t.string   "gap_tertiary",               limit: 255
    t.datetime "vc_last_login"
    t.datetime "vc_last_profile_update"
    t.string   "rco_id",                     limit: 255
  end

  add_index "roster_people", ["region_id", "vc_is_active"], name: "index_roster_people_on_region_active", using: :btree
  add_index "roster_people", ["vc_id"], name: "idx_vc_id", using: :btree

  create_table "roster_position_memberships", force: :cascade do |t|
    t.integer "position_id"
    t.integer "person_id"
    t.boolean "persistent"
  end

  add_index "roster_position_memberships", ["person_id"], name: "index_roster_position_memberships_on_person_id", using: :btree

  create_table "roster_positions", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",                 default: false
    t.string   "abbrev",     limit: 255
  end

  create_table "roster_positions_scheduler_shifts", id: false, force: :cascade do |t|
    t.integer "shift_id"
    t.integer "position_id"
  end

  add_index "roster_positions_scheduler_shifts", ["shift_id", "position_id"], name: "index_roster_positions_scheduler_shifts", unique: true, using: :btree

  create_table "roster_regions", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.string   "code",                        limit: 255
    t.string   "short_name",                  limit: 255
    t.string   "time_zone_raw",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vc_username",                 limit: 255
    t.string   "vc_password",                 limit: 255
    t.string   "vc_position_filter",          limit: 255
    t.hstore   "config"
    t.integer  "vc_unit"
    t.string   "url_slug",                    limit: 255
    t.integer  "incident_number_sequence_id"
    t.string   "vc_hierarchy_name"
  end

  add_index "roster_regions", ["url_slug"], name: "index_roster_regions_on_url_slug", unique: true, using: :btree

  create_table "roster_shift_territories", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",        limit: 255
    t.string   "abbrev",      limit: 255
    t.string   "county_code", limit: 255
    t.string   "fips_code",   limit: 255
    t.string   "gis_name",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                 default: true
  end

  create_table "roster_shift_territory_memberships", force: :cascade do |t|
    t.integer "shift_territory_id"
    t.integer "person_id"
    t.boolean "persistent"
  end

  add_index "roster_shift_territory_memberships", ["person_id"], name: "index_roster_shift_territory_memberships_on_person_id", using: :btree

  create_table "roster_vc_import_data", force: :cascade do |t|
    t.integer  "region_id"
    t.json     "position_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roster_vc_import_data", ["region_id"], name: "index_roster_vc_import_data_on_region_id", using: :btree

  create_table "roster_vc_position_configurations", force: :cascade do |t|
    t.integer "shift_territory_id"
    t.integer "position_id"
    t.integer "vc_position_id"
  end

  create_table "roster_vc_positions", force: :cascade do |t|
    t.string  "name"
    t.integer "region_id"
  end

  create_table "scheduler_dispatch_configs", force: :cascade do |t|
    t.integer  "shift_territory_id"
    t.integer  "backup_first_id"
    t.integer  "backup_second_id"
    t.integer  "backup_third_id"
    t.integer  "backup_fourth_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",               limit: 255, null: false
    t.integer  "shift_first_id"
    t.integer  "shift_second_id"
    t.integer  "shift_third_id"
    t.integer  "shift_fourth_id"
    t.integer  "region_id"
  end

  add_index "scheduler_dispatch_configs", ["backup_first_id"], name: "index_scheduler_dispatch_configs_on_backup_first_id", using: :btree
  add_index "scheduler_dispatch_configs", ["backup_fourth_id"], name: "index_scheduler_dispatch_configs_on_backup_fourth_id", using: :btree
  add_index "scheduler_dispatch_configs", ["backup_second_id"], name: "index_scheduler_dispatch_configs_on_backup_second_id", using: :btree
  add_index "scheduler_dispatch_configs", ["backup_third_id"], name: "index_scheduler_dispatch_configs_on_backup_third_id", using: :btree
  add_index "scheduler_dispatch_configs", ["shift_territory_id"], name: "index_scheduler_dispatch_configs_on_shift_territory_id", using: :btree

  create_table "scheduler_dispatch_configs_admin_notifications", id: false, force: :cascade do |t|
    t.integer "scheduler_dispatch_config_id"
    t.integer "roster_person_id"
  end

  create_table "scheduler_flex_schedules", force: :cascade do |t|
    t.integer  "person_id"
    t.boolean  "available_sunday_day"
    t.boolean  "available_sunday_night"
    t.boolean  "available_monday_day"
    t.boolean  "available_monday_night"
    t.boolean  "available_tuesday_day"
    t.boolean  "available_tuesday_night"
    t.boolean  "available_wednesday_day"
    t.boolean  "available_wednesday_night"
    t.boolean  "available_thursday_day"
    t.boolean  "available_thursday_night"
    t.boolean  "available_friday_day"
    t.boolean  "available_friday_night"
    t.boolean  "available_saturday_day"
    t.boolean  "available_saturday_night"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scheduler_flex_schedules", ["person_id"], name: "index_scheduler_flex_schedules_on_person_id", using: :btree

  create_table "scheduler_notification_settings", force: :cascade do |t|
    t.integer  "email_advance_hours"
    t.integer  "sms_advance_hours"
    t.integer  "sms_only_after",                        default: 0
    t.integer  "sms_only_before",                       default: 86400
    t.boolean  "send_email_invites"
    t.string   "calendar_api_token",        limit: 255
    t.text     "shift_notification_phones"
    t.boolean  "email_swap_requested"
    t.boolean  "email_all_swaps"
    t.boolean  "email_calendar_signups"
    t.integer  "email_all_shifts_at"
    t.integer  "sms_all_shifts_at"
    t.date     "last_all_shifts_email"
    t.date     "last_all_shifts_sms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_all_swaps_daily"
  end

  add_index "scheduler_notification_settings", ["calendar_api_token"], name: "index_scheduler_notification_settings_on_calendar_api_token", unique: true, using: :btree

  create_table "scheduler_shift_assignments", force: :cascade do |t|
    t.integer  "person_id",                           null: false
    t.date     "date",                                null: false
    t.boolean  "email_invite_sent",   default: false
    t.boolean  "email_reminder_sent", default: false
    t.boolean  "sms_reminder_sent",   default: false
    t.boolean  "available_for_swap",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "synced",              default: false
    t.integer  "shift_time_id",                       null: false
    t.integer  "shift_id",                            null: false
    t.boolean  "vc_hours_uploaded",   default: false
    t.text     "note"
  end

  add_index "scheduler_shift_assignments", ["date", "person_id", "shift_id", "shift_time_id"], name: "index_scheduler_shift_assignment_fields", unique: true, using: :btree
  add_index "scheduler_shift_assignments", ["person_id"], name: "index_scheduler_shift_assignments_on_person_id", using: :btree
  add_index "scheduler_shift_assignments", ["shift_id", "date"], name: "index_scheduler_shift_assignments_on_shift_date", using: :btree

  create_table "scheduler_shift_categories", force: :cascade do |t|
    t.integer  "region_id"
    t.string   "name",       limit: 255
    t.boolean  "show",                   default: false, null: false
    t.integer  "ordinal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                default: true,  null: false
  end

  add_index "scheduler_shift_categories", ["region_id"], name: "index_scheduler_shift_categories_on_region_id", using: :btree

  create_table "scheduler_shift_times", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "period",           limit: 255
    t.integer  "start_offset"
    t.integer  "end_offset"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active_sunday",                default: true, null: false
    t.boolean  "active_monday",                default: true, null: false
    t.boolean  "active_tuesday",               default: true, null: false
    t.boolean  "active_wednesday",             default: true, null: false
    t.boolean  "active_thursday",              default: true, null: false
    t.boolean  "active_friday",                default: true, null: false
    t.boolean  "active_saturday",              default: true, null: false
    t.boolean  "enabled",                      default: true, null: false
  end

  add_index "scheduler_shift_times", ["region_id"], name: "index_scheduler_shift_times_on_region_id", using: :btree

  create_table "scheduler_shift_times_shifts", id: false, force: :cascade do |t|
    t.integer "shift_id",      null: false
    t.integer "shift_time_id", null: false
  end

  add_index "scheduler_shift_times_shifts", ["shift_id", "shift_time_id"], name: "idx_scheduler_shift_times_shifts_unique", unique: true, using: :btree

  create_table "scheduler_shifts", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.string   "abbrev",                   limit: 255
    t.integer  "max_signups"
    t.integer  "shift_territory_id"
    t.integer  "ordinal"
    t.integer  "spreadsheet_ordinal"
    t.date     "shift_begins"
    t.date     "shift_ends"
    t.date     "signups_frozen_before"
    t.integer  "max_advance_signup"
    t.date     "signups_available_before"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_desired_signups"
    t.boolean  "ignore_shift_territory",               default: false
    t.integer  "min_advance_signup",                   default: 0,     null: false
    t.integer  "shift_category_id"
    t.boolean  "exclusive",                            default: true,  null: false
    t.string   "vc_hours_type",            limit: 255
    t.boolean  "show_in_dispatch_console",             default: true,  null: false
  end

  add_index "scheduler_shifts", ["shift_territory_id"], name: "index_scheduler_shifts_on_shift_territory_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255, null: false
    t.integer  "item_id",                    null: false
    t.string   "event",          limit: 255, null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.string   "root_type",      limit: 255
    t.integer  "root_id"
    t.integer  "region_id",                  null: false
  end

  add_index "versions", ["created_at"], name: "index_versions_on_created_at", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["region_id", "root_type", "root_id"], name: "index_versions_on_region_id_root_type_root_id", using: :btree

  add_foreign_key "incidents_dat_incidents", "incidents_incidents", column: "incident_id", name: "incidents_ref"
  add_foreign_key "roster_position_memberships", "roster_people", column: "person_id", name: "person_id_ref", on_delete: :cascade
  add_foreign_key "roster_shift_territory_memberships", "roster_people", column: "person_id", name: "person_id_ref", on_delete: :cascade
  add_foreign_key "scheduler_shift_assignments", "roster_people", column: "person_id", name: "person_id_ref", on_delete: :cascade
  add_foreign_key "scheduler_shift_assignments", "scheduler_shift_times", column: "shift_time_id", name: "shift_group_id_ref"
  add_foreign_key "scheduler_shift_assignments", "scheduler_shifts", column: "shift_id", name: "shift_id_ref"
end

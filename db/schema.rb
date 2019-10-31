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

ActiveRecord::Schema.define(version: 2019_10_28_180239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issues", force: :cascade do |t|
    t.string "title", limit: 191, null: false
    t.bigint "number", null: false
    t.integer "gh_database_id", null: false
    t.string "url", limit: 191, null: false
    t.bigint "repository_id", null: false
    t.boolean "open", default: true, null: false
    t.bigint "timeline_events"
    t.bigint "participants"
    t.float "quality", default: 1.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gh_database_id"], name: "index_issues_on_gh_database_id", unique: true
    t.index ["repository_id"], name: "index_issues_on_repository_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "pr_stats", force: :cascade do |t|
    t.jsonb "data", null: false
    t.string "pr_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer "gh_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repo_stats", force: :cascade do |t|
    t.jsonb "data", null: false
    t.string "repo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repositories", force: :cascade do |t|
    t.bigint "gh_database_id", null: false
    t.string "url", limit: 191, null: false
    t.string "name", null: false
    t.string "full_name", null: false
    t.bigint "pull_requests_count", default: 0
    t.integer "language_id"
    t.string "description", limit: 191
    t.string "code_of_conduct_url", limit: 191
    t.bigint "forks"
    t.bigint "stars"
    t.bigint "watchers"
    t.boolean "banned", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gh_database_id"], name: "index_repositories_on_gh_database_id", unique: true
  end

  create_table "shirt_coupons", force: :cascade do |t|
    t.string "code", null: false
    t.integer "user_id"
    t.integer "lock_version", default: 0
    t.index ["code"], name: "index_shirt_coupons_on_code", unique: true
    t.index ["user_id"], name: "index_shirt_coupons_on_user_id", unique: true
  end

  create_table "spam_repositories", force: :cascade do |t|
    t.integer "github_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_id"], name: "index_spam_repositories_on_github_id", unique: true
  end

  create_table "sticker_coupons", force: :cascade do |t|
    t.string "code", null: false
    t.integer "user_id"
    t.integer "lock_version", default: 0
    t.index ["code"], name: "index_sticker_coupons_on_code", unique: true
    t.index ["user_id"], name: "index_sticker_coupons_on_user_id", unique: true
  end

  create_table "user_stats", force: :cascade do |t|
    t.jsonb "data"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "uid"
    t.string "provider_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "github"
    t.boolean "terms_acceptance", default: false
    t.boolean "marketing_emails", default: false
    t.string "state"
    t.datetime "waiting_since"
    t.jsonb "receipt"
  end

end

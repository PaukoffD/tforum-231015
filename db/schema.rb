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

ActiveRecord::Schema.define(version: 20_160_413_094_424) do
  create_table 'admins', force: :cascade do |t|
    t.string 'email',                  default: '', null: false
    t.string 'encrypted_password',     default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
  end

  add_index 'admins', ['email'], name: 'index_admins_on_email', unique: true
  add_index 'admins', ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at',                 null: false
    t.datetime 'updated_at',                 null: false
    t.string 'slug'
    t.integer 'position',   default: 0
    t.boolean 'hidden',     default: false
  end

  create_table 'categories_groups', force: :cascade do |t|
    t.integer 'category_id'
    t.integer 'group_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  create_table 'ckeditor_assets', force: :cascade do |t|
    t.string 'data_file_name', null: false
    t.string 'data_content_type'
    t.integer 'data_file_size'
    t.integer 'assetable_id'
    t.string 'assetable_type',    limit: 30
    t.string 'type',              limit: 30
    t.integer 'width'
    t.integer 'height'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'ckeditor_assets', %w(assetable_type assetable_id), name: 'idx_ckeditor_assetable'
  add_index 'ckeditor_assets', %w(assetable_type type assetable_id), name: 'idx_ckeditor_assetable_type'

  create_table 'forums', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'category_id'
    t.integer 'views_count', default: 0
    t.string 'slug'
    t.datetime 'created_at',              null: false
    t.datetime 'updated_at',              null: false
    t.boolean 'hidden'
  end

  create_table 'friendly_id_slugs', force: :cascade do |t|
    t.string 'slug', null: false
    t.integer 'sluggable_id', null: false
    t.string 'sluggable_type', limit: 50
    t.string 'scope'
    t.datetime 'created_at'
  end

  add_index 'friendly_id_slugs', %w(slug sluggable_type scope), name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope', unique: true
  add_index 'friendly_id_slugs', %w(slug sluggable_type), name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
  add_index 'friendly_id_slugs', ['sluggable_id'], name: 'index_friendly_id_slugs_on_sluggable_id'
  add_index 'friendly_id_slugs', ['sluggable_type'], name: 'index_friendly_id_slugs_on_sluggable_type'

  create_table 'groups', force: :cascade do |t|
    t.string 'name'
    t.integer 'forum_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'groups_users', force: :cascade do |t|
    t.integer 'group_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'identities', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'provider'
    t.string 'uid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'identities', ['user_id'], name: 'index_identities_on_user_id'

  create_table 'memberships', force: :cascade do |t|
    t.integer 'forum_id'
    t.integer 'group_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.integer 'topic_id'
    t.text 'text'
    t.integer 'user_id'
    t.datetime 'created_at',                             null: false
    t.datetime 'updated_at',                             null: false
    t.integer 'reply_to_id'
    t.string 'state', default: 'pending_review'
    t.boolean 'notified', default: false
    t.text 'summary'
  end

  create_table 'private_posts', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'topic'
    t.text 'text'
    t.integer 'user_id_sent'
    t.datetime 'created_at',                              null: false
    t.datetime 'updated_at',                              null: false
    t.string 'state', default: 'pending_review'
    t.boolean 'notified', default: false
  end

  create_table 'taggings', force: :cascade do |t|
    t.integer 'tag_id'
    t.integer 'taggable_id'
    t.string 'taggable_type'
    t.integer 'tagger_id'
    t.string 'tagger_type'
    t.string 'context', limit: 128
    t.datetime 'created_at'
  end

  add_index 'taggings', %w(tag_id taggable_id taggable_type context tagger_id tagger_type), name: 'taggings_idx', unique: true
  add_index 'taggings', %w(taggable_id taggable_type context), name: 'index_taggings_on_taggable_id_and_taggable_type_and_context'

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.integer 'taggings_count', default: 0
  end

  add_index 'tags', ['name'], name: 'index_tags_on_name', unique: true

  create_table 'topics', force: :cascade do |t|
    t.integer 'forum_id'
    t.integer 'user_id'
    t.string 'subject'
    t.datetime 'created_at',                              null: false
    t.datetime 'updated_at',                              null: false
    t.boolean 'locked',       default: false, null: false
    t.boolean 'pinned',       default: false
    t.boolean 'hidden',       default: false
    t.datetime 'last_post_at'
    t.string 'state', default: 'pending_review'
    t.integer 'views_count', default: 0
    t.string 'slug'
    t.integer 'last_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email',                  default: '',    null: false
    t.string 'encrypted_password',     default: '',    null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.datetime 'created_at',                             null: false
    t.datetime 'updated_at',                             null: false
    t.string 'name'
    t.boolean 'admin', default: false
    t.string 'avatar_file_name'
    t.string 'avatar_content_type'
    t.integer 'avatar_file_size'
    t.datetime 'avatar_updated_at'
    t.integer 'private',                default: 0,     null: false
    t.integer 'count_message',          default: 0,     null: false
  end

  add_index 'users', ['email'], name: 'index_users_on_email', unique: true
  add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
end

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

ActiveRecord::Schema.define(version: 20160728141601) do

  create_table "assemblies", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "version",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "biotypes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "biotypes", ["name"], name: "index_biotypes_on_name", using: :btree

  create_table "chromosomes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "species_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "chromosomes_scaffolds", id: false, force: :cascade do |t|
    t.integer "chromosome_id", limit: 4, null: false
    t.integer "scaffold_id",   limit: 4, null: false
  end

  add_index "chromosomes_scaffolds", ["chromosome_id", "scaffold_id"], name: "index_chromosomes_scaffolds_on_chromosome_id_and_scaffold_id", using: :btree
  add_index "chromosomes_scaffolds", ["scaffold_id", "chromosome_id"], name: "index_chromosomes_scaffolds_on_scaffold_id_and_chromosome_id", using: :btree

  create_table "deleted_scaffolds", force: :cascade do |t|
    t.integer  "scaffold_id", limit: 4
    t.integer  "library_id",  limit: 4
    t.float    "cov_avg",     limit: 24
    t.float    "cov_sd",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "deleted_scaffolds", ["library_id"], name: "index_deleted_scaffolds_on_library_id", using: :btree
  add_index "deleted_scaffolds", ["scaffold_id", "library_id"], name: "index_deleted_scaffolds_on_scaffold_id_and_library_id", unique: true, using: :btree
  add_index "deleted_scaffolds", ["scaffold_id"], name: "index_deleted_scaffolds_on_scaffold_id", using: :btree

  create_table "effect_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "effects", force: :cascade do |t|
    t.integer  "snp_id",           limit: 4
    t.integer  "feature_id",       limit: 4
    t.integer  "effect_type_id",   limit: 4
    t.integer  "cdna_position",    limit: 4
    t.integer  "cds_position",     limit: 4
    t.string   "amino_acids",      limit: 8
    t.string   "codons",           limit: 7
    t.float    "sift_score",       limit: 24
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "protein_position", limit: 4
  end

  add_index "effects", ["feature_id"], name: "index_effects_on_feature_id", using: :btree
  add_index "effects", ["snp_id"], name: "index_effects_on_snp_id", using: :btree

  create_table "feature_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "feature_types", ["name"], name: "index_feature_types_on_name", using: :btree

  create_table "features", force: :cascade do |t|
    t.integer  "region_id",       limit: 4
    t.integer  "feature_type_id", limit: 4
    t.integer  "biotype_id",      limit: 4
    t.integer  "parent_id",       limit: 4
    t.string   "orientation",     limit: 1
    t.integer  "frame",           limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",            limit: 255
  end

  add_index "features", ["biotype_id"], name: "index_features_on_biotype_id", using: :btree
  add_index "features", ["feature_type_id"], name: "index_features_on_feature_type_id", using: :btree
  add_index "features", ["parent_id"], name: "fk_rails_9d0950db85", using: :btree
  add_index "features", ["region_id"], name: "index_features_on_region_id", using: :btree

  create_table "gene_sets", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "gene_sets", ["name"], name: "index_gene_sets_on_name", using: :btree

  create_table "genes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "cdna",        limit: 255
    t.string   "position",    limit: 255
    t.string   "gene",        limit: 255
    t.string   "transcript",  limit: 255
    t.integer  "gene_set_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "description", limit: 65535
    t.integer  "feature_id",  limit: 4
  end

  add_index "genes", ["feature_id"], name: "index_genes_on_feature_id", using: :btree
  add_index "genes", ["gene"], name: "index_genes_on_gene", using: :btree
  add_index "genes", ["gene_set_id"], name: "index_genes_on_gene_set_id", using: :btree
  add_index "genes", ["name"], name: "index_genes_on_name", using: :btree
  add_index "genes", ["transcript"], name: "index_genes_on_transcript", using: :btree

  create_table "genetic_maps", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "line_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "libraries", ["line_id"], name: "index_libraries_on_line_id", using: :btree

  create_table "lines", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "mutant",      limit: 1
    t.integer  "species_id",  limit: 4
    t.integer  "wildtype_id", limit: 4
  end

  add_index "lines", ["name"], name: "index_lines_on_name", using: :btree
  add_index "lines", ["species_id"], name: "index_lines_on_species_id", using: :btree

  create_table "map_positions", force: :cascade do |t|
    t.integer  "order",          limit: 4
    t.float    "centimorgan",    limit: 24
    t.integer  "genetic_map_id", limit: 4
    t.integer  "marker_id",      limit: 4
    t.integer  "chromosome_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "map_positions", ["chromosome_id"], name: "index_map_positions_on_chromosome_id", using: :btree
  add_index "map_positions", ["genetic_map_id"], name: "index_map_positions_on_genetic_map_id", using: :btree
  add_index "map_positions", ["marker_id"], name: "index_map_positions_on_marker_id", using: :btree

  create_table "marker_alias_details", force: :cascade do |t|
    t.string   "alias_detail", limit: 255
    t.string   "description",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "marker_names", force: :cascade do |t|
    t.string  "alias",                  limit: 255
    t.integer "marker_id",              limit: 4
    t.integer "marker_alias_detail_id", limit: 4
  end

  add_index "marker_names", ["alias"], name: "index_marker_names_on_alias", using: :btree
  add_index "marker_names", ["marker_alias_detail_id"], name: "index_marker_names_on_marker_alias_detail_id", using: :btree
  add_index "marker_names", ["marker_id"], name: "index_marker_names_on_marker_id", using: :btree

  create_table "marker_sets", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "markers", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "positions_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "marker_set_id", limit: 4
    t.string   "sequence",      limit: 255
  end

  add_index "markers", ["marker_set_id"], name: "index_markers_on_marker_set_id", using: :btree
  add_index "markers", ["positions_id"], name: "index_markers_on_positions_id", using: :btree

  create_table "multi_maps", force: :cascade do |t|
    t.integer  "snp_id",      limit: 4
    t.integer  "scaffold_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "multi_maps", ["scaffold_id", "snp_id"], name: "index_multi_maps_on_scaffold_id_and_snp_id", unique: true, using: :btree
  add_index "multi_maps", ["scaffold_id"], name: "index_multi_maps_on_scaffold_id", using: :btree
  add_index "multi_maps", ["snp_id"], name: "index_multi_maps_on_snp_id", using: :btree

  create_table "mutation_consequences", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "mutation_consequences", ["name"], name: "index_mutation_consequences_on_name", using: :btree

  create_table "mutations", force: :cascade do |t|
    t.string   "het_hom",       limit: 255
    t.integer  "wt_cov",        limit: 4
    t.integer  "mut_cov",       limit: 4
    t.string   "confidence",    limit: 255
    t.integer  "gene_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "snp_id",        limit: 4
    t.integer  "library_id",    limit: 4
    t.integer  "total_cov",     limit: 4
    t.integer  "mm_count",      limit: 4
    t.string   "hom_corrected", limit: 1
  end

  add_index "mutations", ["gene_id"], name: "index_mutations_on_gene_id", using: :btree
  add_index "mutations", ["library_id"], name: "index_mutations_on_library_id", using: :btree
  add_index "mutations", ["snp_id", "library_id"], name: "index_mutations_on_snp_id_and_library_id", unique: true, using: :btree
  add_index "mutations", ["snp_id"], name: "index_mutations_on_snp_id", using: :btree

  create_table "primer_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "primers", force: :cascade do |t|
    t.integer  "snp_id",         limit: 4
    t.integer  "primer_type_id", limit: 4
    t.string   "orientation",    limit: 1
    t.string   "wt",             limit: 255
    t.string   "alt",            limit: 255
    t.string   "common",         limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "primers", ["primer_type_id"], name: "index_primers_on_primer_type_id", using: :btree
  add_index "primers", ["snp_id"], name: "index_primers_on_snp_id", using: :btree

  create_table "region_coverages", force: :cascade do |t|
    t.integer  "library_id", limit: 4
    t.integer  "region_id",  limit: 4
    t.float    "coverage",   limit: 24
    t.string   "hom",        limit: 1
    t.string   "het",        limit: 1
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "region_coverages", ["library_id"], name: "index_region_coverages_on_library_id", using: :btree
  add_index "region_coverages", ["region_id"], name: "index_region_coverages_on_region_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.integer  "scaffold_id", limit: 4
    t.integer  "start",       limit: 4
    t.integer  "end",         limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "regions", ["scaffold_id", "start", "end"], name: "index_regions_on_scaffold_id_and_start_and_end", unique: true, using: :btree
  add_index "regions", ["scaffold_id"], name: "index_regions_on_scaffold_id", using: :btree

  create_table "scaffold_mappings", force: :cascade do |t|
    t.integer  "scaffold_id",       limit: 4
    t.integer  "coordinate",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "other_coordinate",  limit: 4
    t.integer  "other_scaffold_id", limit: 4
  end

  add_index "scaffold_mappings", ["scaffold_id"], name: "index_scaffold_mappings_on_scaffold_id", using: :btree

  create_table "scaffold_maps", force: :cascade do |t|
    t.integer  "scaffold_id",    limit: 4
    t.integer  "chromosome_id",  limit: 4
    t.integer  "genetic_map_id", limit: 4
    t.float    "cm",             limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "scaffold_maps", ["chromosome_id"], name: "index_scaffold_maps_on_chromosome_id", using: :btree
  add_index "scaffold_maps", ["cm"], name: "index_scaffold_maps_on_cm", using: :btree
  add_index "scaffold_maps", ["genetic_map_id"], name: "index_scaffold_maps_on_genetic_map_id", using: :btree
  add_index "scaffold_maps", ["scaffold_id"], name: "index_scaffold_maps_on_scaffold_id", using: :btree

  create_table "scaffolds", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "length",      limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "assembly_id", limit: 4
    t.integer  "chromosome",  limit: 4
  end

  add_index "scaffolds", ["assembly_id"], name: "index_scaffolds_on_assembly_id", using: :btree
  add_index "scaffolds", ["name"], name: "index_scaffolds_on_name", using: :btree

  create_table "scaffolds_markers", id: false, force: :cascade do |t|
    t.integer "scaffold_id",          limit: 4
    t.integer "marker_id",            limit: 4
    t.float   "identity",             limit: 24
    t.integer "marker_start",         limit: 4
    t.integer "marker_end",           limit: 4
    t.string  "marker_orientation",   limit: 1
    t.integer "scaffold_start",       limit: 4
    t.integer "scaffold_end",         limit: 4
    t.string  "scaffold_orientation", limit: 1
    t.string  "sequence",             limit: 500
  end

  add_index "scaffolds_markers", ["marker_id"], name: "index_scaffolds_markers_on_marker_id", using: :btree
  add_index "scaffolds_markers", ["marker_start"], name: "index_scaffolds_markers_on_marker_start", using: :btree
  add_index "scaffolds_markers", ["scaffold_id"], name: "index_scaffolds_markers_on_scaffold_id", using: :btree
  add_index "scaffolds_markers", ["scaffold_start"], name: "index_scaffolds_markers_on_scaffold_start", using: :btree

  create_table "snps", force: :cascade do |t|
    t.integer  "scaffold_id", limit: 4
    t.integer  "position",    limit: 4
    t.string   "ref",         limit: 1
    t.string   "wt",          limit: 8
    t.string   "alt",         limit: 8
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "species_id",  limit: 4
  end

  add_index "snps", ["position"], name: "index_snps_on_position", using: :btree
  add_index "snps", ["scaffold_id", "species_id", "position", "wt", "alt"], name: "snp_species_index", unique: true, using: :btree
  add_index "snps", ["scaffold_id"], name: "index_snps_on_scaffold_id", using: :btree
  add_index "snps", ["species_id"], name: "index_snps_on_species_id", using: :btree

  create_table "species", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "scientific_name", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "deleted_scaffolds", "libraries"
  add_foreign_key "deleted_scaffolds", "scaffolds"
  add_foreign_key "features", "biotypes"
  add_foreign_key "features", "feature_types"
  add_foreign_key "features", "features", column: "parent_id"
  add_foreign_key "features", "regions"
  add_foreign_key "genes", "features"
  add_foreign_key "libraries", "lines"
  add_foreign_key "lines", "species"
  add_foreign_key "marker_names", "markers"
  add_foreign_key "multi_maps", "scaffolds"
  add_foreign_key "multi_maps", "snps"
  add_foreign_key "mutations", "genes"
  add_foreign_key "mutations", "libraries"
  add_foreign_key "mutations", "snps"
  add_foreign_key "primers", "primer_types"
  add_foreign_key "primers", "snps"
  add_foreign_key "region_coverages", "libraries"
  add_foreign_key "region_coverages", "regions"
  add_foreign_key "regions", "scaffolds"
  add_foreign_key "scaffold_mappings", "scaffolds"
  add_foreign_key "scaffold_maps", "chromosomes"
  add_foreign_key "scaffold_maps", "genetic_maps"
  add_foreign_key "scaffold_maps", "scaffolds"
  add_foreign_key "snps", "scaffolds"
  add_foreign_key "snps", "species"
end

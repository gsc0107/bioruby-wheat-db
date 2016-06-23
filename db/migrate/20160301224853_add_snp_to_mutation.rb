class AddSnpToMutation < ActiveRecord::Migration
  def change
    add_reference :mutations, :snp, index: true
    add_foreign_key :mutations, :SNPs
  end
end

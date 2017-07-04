class CreateRbacCoreAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :rbac_core_assignments do |t|
      t.references :subjectable, polymorphic: true, null: false, index: {name: "index_rbac_core_assignments_on_subjectable"}
      t.references :role, foreign_key: {to_table: :rbac_core_roles}, null: false, index: true

      t.timestamps
    end
  end
end

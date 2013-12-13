ActiveAdmin.register Team do

  index do
    selectable_column
    column :name
    column :owner
    column :updated_at
    default_actions
  end

#  config.sort_order = "updated_at_dsc"


  filter :owner
  filter :members

  show do
    attributes_table do
      row :id
      row :name
      row :owner
      row :created_at
      row :updated_at
    end
    panel "Snaphots" do
      table_for team.snapshots do
        column "id" do |snapshot|
#          link_to(snapshot.id, admin_snapshots_path(snapshot))
          link_to(snapshot.id, "/admin/snapshots/" + snapshot.id.to_s)
        end
        column "position" do |snapshot|
          link_to(snapshot.position, "/admin/snapshots/" + snapshot.id.to_s)
        end
        column "created_at"
      end
    end

  end
end


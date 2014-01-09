ActiveAdmin.register EssenceVersion do



#  permit_params :name, :owner
#
  index do |version|
    selectable_column
    column :id
    column :name
    #column "Name" do |version|
    #  link_to(version.name, admin_essence_versions_path(version))
    #end
    column :created_at
    default_actions
  end

  before_filter :only => [:show, :edit, :update, :destroy] do
      @essence_version = EssenceVersion.find_by_param(params[:id])
    end

##  config.sort_order = "updated_at_dsc"
#
#
#  filter :owner
#  filter :members
#
  show do
    attributes_table do
      row :id
      row :name
      row :created_at
    end
#    panel "Snaphots" do
#      table_for team.snapshots do
#        column "id" do |snapshot|
##          link_to(snapshot.id, admin_snapshots_path(snapshot))
#          link_to(snapshot.id, "/admin/snapshots/" + snapshot.id.to_s)
#        end
#        column "position" do |snapshot|
#          link_to(snapshot.position, "/admin/snapshots/" + snapshot.id.to_s)
#        end
#        column "created_at"
#      end
#    end
#
  end
end


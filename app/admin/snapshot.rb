ActiveAdmin.register Snapshot do

  permit_params :team, :position, :created_at, :updated_at

  index do
    selectable_column
    column :team
    column :position
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :team
      f.input :position
      f.input :created_at, :as => :datetime_picker, :hint => "This works in Chrome"
      f.input :updated_at, :as => :datetime_picker, :hint => "This works in Chrome"
    end
    f.actions
  end


end

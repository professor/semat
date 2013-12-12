ActiveAdmin.register Snapshot do

  index do
    selectable_column
    column :team
    column :order
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :team
      f.input :order
      f.input :created_at, :as => :datetime_picker, :hint => "This works in Chrome"
      f.input :updated_at, :as => :datetime_picker, :hint => "This works in Chrome"
    end
    f.actions
  end


end

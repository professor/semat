ActiveAdmin.register User do

  permit_params :email

  index do
    selectable_column
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  #controller do
  # defaults :finder => :find_by_param
  #end

  before_filter :only => [:show, :edit, :update, :destroy] do
      @user = User.find_by_param(params[:id])
    end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end

  show do
    attributes_table do
      row :email
      row :authentication_token
      row :confirmed_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
    end
    active_admin_comments
  end
end


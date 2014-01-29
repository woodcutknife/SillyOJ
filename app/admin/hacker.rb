ActiveAdmin.register Hacker do

  index do
    selectable_column
    column(:id) { |hacker| link_to(hacker.id, admin_hacker_path(hacker)) }
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count

    default_actions
  end

end

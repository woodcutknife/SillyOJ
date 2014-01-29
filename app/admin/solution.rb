ActiveAdmin.register Solution do

  index do
    selectable_column
    column(:id) { |solution| link_to(solution.id, admin_solution_path(solution)) }
    column(:hacker) { |solution| link_to(Hacker.find(solution.hacker_id).name, admin_hacker_path(solution.hacker_id)) }
    column :language
    column :time_cost
    column :memory_cost
    column :result
    column :created_at

    default_actions
  end

end

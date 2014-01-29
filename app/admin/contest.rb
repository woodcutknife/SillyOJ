ActiveAdmin.register Contest do

  controller do
    def permitted_params
      params.permit(contest: [:name, :mode, :description, :start_time, :end_time, :puzzle_ids => []])
    end
  end

  index do
    selectable_column
    column(:id) { |contest| link_to(contest.id, admin_contest_path(contest)) }
    column :name
    column :start_time
    column :end_time

    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :mode, as: :select, collection: ['OI', 'ACM']
      f.input :description
      f.input :start_time
      f.input :end_time
      f.input :puzzles, as: :select
    end
    f.actions
  end

end

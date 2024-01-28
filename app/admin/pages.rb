ActiveAdmin.register Page do
  form do |f|
    f.semantic_errors
    inputs do
      f.input :user
      f.input :title
      f.input :summary
      f.input :content
      f.input :tags_string, label: 'Tags',input_html: {value: f.object.tags_string_for_form}
      f.input :published
    end
    f.actions
  end

  permit_params :user_id,:title,:content,:summary,:published,:tags_string

  show do
    attributes_table do
      row :user
      row :title
      row :content
      row :summary
      row :slug
      row ('Tags') {|p| p.tags_string_for_form}
      row :published
    end
  end

  index do
    column :title
    column('Tags') {|p| p.tags_string_for_form}
    column :published
    column('Preview') do |p|
      path = "/page/#{p.slug}"
      link_to path, path, target: "_blank"
    end
    actions
  end
end
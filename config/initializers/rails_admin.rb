# frozen_string_literal: true

RailsAdmin.config do |config|
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    show
    edit
    delete
  end

  config.model 'User' do
    exclude_fields :password_digest
    create do
      include_all_fields
      field :password
    end
  end
end

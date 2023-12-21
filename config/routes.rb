# config/routes.rb

Rails.application.routes.draw do
  # Your other routes go here

  post '/chat_responses', to: 'chat_responses#process_json', defaults: { format: :json }
end

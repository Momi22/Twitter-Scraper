# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'send-topic', to: 'twitters#send_topic'
    end
  end
end

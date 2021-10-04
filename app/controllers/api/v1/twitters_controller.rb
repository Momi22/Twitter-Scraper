# frozen_string_literal: true

module Api
  module V1
    class TwittersController < ApplicationController
      before_action :invalid_parameter, only: [:send_topic]

      def send_topic
        req = TwitterScraper.send_request(request.ip, params[:topic])
        if req == :unknown_error
          render json: { status: 0, errorMessage: I18n.t('controller.unknown_error') },
                 status: :unprocessable_entity
        elsif req == :exceed_try
          render json: { status: 0, errorMessage: I18n.t('controller.exceed_try') },
                 status: :unprocessable_entity
        else
          render json: { status: 1, data: { message: I18n.t('controller.successful_done') } }, status: :ok
        end
      end

      private

      def invalid_parameter
        return if params[:topic].present?

        render json: { status: 0, errorMessage: I18n.t('controller.cant_process_request') },
               status: :unprocessable_entity
      end
    end
  end
end

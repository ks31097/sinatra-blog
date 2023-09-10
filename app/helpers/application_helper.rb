# frozen_string_literal: true

module ApplicationHelper
  private

  # @show the current time
  def time_now
    Time.now
  end

  # @response sinatra-flash errors
  def error_message(object)
    object.errors.full_messages
  end
end

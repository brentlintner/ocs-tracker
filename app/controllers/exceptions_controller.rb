class ExceptionsController < ApplicationController
  def index
    exception = request.env["action_dispatch.exception"]

    if exception.present?
      @status = ActionDispatch::ExceptionWrapper.new(
        request.env,
        exception
      ).status_code
    else
      @status = 500
    end

    render(
      "exceptions/index",
      formats: [ "html" ],
      layout: "application",
      status: @status)
  end
end

class EmailAlertsController < ApplicationController
  before_action :set_title
  before_action :set_search

  def subscribe
    if request.post?
      email = params.permit(:email)[:email]
      @email_alert_user = EmailAlertUser.find_or_initialize_by email: email
      @email_alert_user.save
      unless @email_alert_user.errors.any?
        @email_alert_user.send_confirmation_email
        redirect_to alerts_sent_path
      end
    else
      @email_alert_user = EmailAlertUser.new
    end
  end

  def confirm
    sgid = params.permit(:token)[:token]

    begin
      @email_alert_user = GlobalID::Locator.locate_signed(sgid, for: "alerts")
    rescue ActiveRecord::RecordNotFound
      @email_alert_user = nil
    end

    if @email_alert_user.present? && !@email_alert_user.confirmed?
      @email_alert_user.update! confirmed: true
      StockMailer.new_user.deliver_later
    end
  end

  def unsubscribe
    @status = false

    sgid = params.permit(:token)[:token]

    begin
      @email_alert_user = GlobalID::Locator.locate_signed(sgid, for: "alerts")
    rescue ActiveRecord::RecordNotFound
      @email_alert_user = nil
    end

    if @email_alert_user.present?
      @email_alert_user.destroy!
      @status = true
    end
  end

  def sent
  end

protected

  def set_title
    @title = "Email Alerts"
  end
end

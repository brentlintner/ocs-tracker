class StockMailer < ApplicationMailer
  default from: ENV["SMTP_DEFAULT_FROM"]

  # ---- user emails ----

  def recently_stocked product_ids, email, token
    @products = Product.where(id: product_ids)
    @token = token
    mail to: email, subject: "OCS Tracker: Recently Stocked Items"
  end

  def confirmation_email email, token
    @token = token
    mail to: email, subject: "OCS Tracker: Please Confirm Your Email"
  end

  # ---- admin emails ----

  def new_user email=ENV["SMTP_DEFAULT_TO"]
    @total = EmailAlertUser.count
    mail to: email, subject: "OCS Tracker: New Alert Signup"
  end
end

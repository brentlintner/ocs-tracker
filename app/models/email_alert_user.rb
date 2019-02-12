class EmailAlertUser < ApplicationRecord
  validates(
    :email,
    presence: true,
    format: {
      with: URI::MailTo::EMAIL_REGEXP,
      message: "must be a valid email"
    })

  def send_recently_stocked_email product_ids
    StockMailer.recently_stocked(
      product_ids,
      email,
      temporary_token
    ).deliver_later
  end

  def send_confirmation_email
    StockMailer.confirmation_email(email, temporary_token).deliver_later
  end

  def self.confirmed
    where(confirmed: true)
  end

private

  def temporary_token
    to_sgid(expires_in: 2.hours, for: "alerts").to_s
  end
end

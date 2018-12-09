class Main < MailForm::Base
  attribute :name,  validate: true
  attribute :email, email: true, validate: true
  attribute :message, validate: true
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: "Note App Mensaje",
      to: "jaimecanalesmarin@gmail.com",
      from: %("#{name}" <#{email}>)
    }
  end
end

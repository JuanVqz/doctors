# frozen_string_literal: true

class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.first, { token: :token })
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, { token: :token })
  end
end

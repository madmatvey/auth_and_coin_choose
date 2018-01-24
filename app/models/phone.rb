class Phone < ApplicationRecord
  belongs_to :user, optional: true
  has_many :validation_tokens
  has_one :confirm_code, -> { where(phone_id: @id) }, class_name: 'ValidationToken'

  def send_validation
    if self.number != nil
      phone_object = TelephoneNumber.parse(self.number) # https://github.com/mobi/telephone_number
      if phone_object.valid?
        client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid,
        Rails.application.secrets.twilio_auth_token
        tk = ValidationToken.create(phone_id: self.id)

        # for dummy tests commenting below code
        # client.api.account.messages.create({
        #   messaging_service_sid: Rails.application.secrets.messaging_service_sid,
        #   to: phone_object.e164_number,
        #   body: "Code: #{tk.token}"})
      end
    end
  end

  # @param [String, #read] token from user input, example: "321456"
  # @return [Boolean] true if token is good and update Phone attributes, false if expired
  def check_token(token_to_check)
    token_sended = self.validation_tokens.last
    if token_sended.is_on_time?
      token_sended.token == token_to_check
      update_attribute('active', true)
      update_attribute('valid_number', true)
    else
      puts "token expired!"
      false
    end
  end

end

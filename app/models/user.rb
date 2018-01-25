class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :phones, dependent: :destroy
  has_one :current_phone, -> { where(active: true) }, class_name: 'Phone'
  has_one :currency

  # @return [String] - example: "79991231234"
  # def phone_number
  #   number ||= current_phone.number
  # end
end

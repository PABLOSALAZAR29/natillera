class Persona < ApplicationRecord
  enum :tipo, { socio: 0, externo: 1 }

  normalizes :nombre, :documento, :celular, with: ->(valor) { valor.strip }

  validates :nombre, presence: true
  validates :documento, presence: true, uniqueness: true
  validates :celular, presence: true,
                      format: { with: /\A\d{10}\z/, message: "debe tener 10 dígitos" }
end
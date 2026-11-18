class Ciclo < ApplicationRecord
  enum :estado, { activo: 0, cerrado: 1 }

  normalizes :nombre, with: ->(valor) { valor.strip }

  validates :nombre, presence: true
  validates :fecha_inicio, :fecha_fin, presence: true
  validates :ahorro_minimo, numericality: { only_integer: true, greater_than: 0 }
  validates :tasa_prestamo, :multa_diaria, :dias_gracia,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :fecha_fin_posterior_a_inicio
  validate :un_solo_ciclo_activo, if: :activo?

  private

  def fecha_fin_posterior_a_inicio
    return if fecha_inicio.blank? || fecha_fin.blank?

    errors.add(:fecha_fin, "debe ser posterior a la fecha de inicio") if fecha_fin <= fecha_inicio
  end

  def un_solo_ciclo_activo
    return unless Ciclo.activo.where.not(id: id).exists?

    errors.add(:estado, "ya existe un ciclo activo; ciérralo antes de abrir otro")
 end
 
end
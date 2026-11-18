class Inscripcion < ApplicationRecord
  belongs_to :persona
  belongs_to :ciclo

  enum :periodicidad, { quincenal: 0, mensual: 1 }
  enum :estado, { activa: 0, anulada: 1 }

  validates :valor_ahorro, numericality: { only_integer: true, greater_than: 0 }
  validate :valor_no_menor_al_minimo_del_ciclo
  validate :persona_debe_ser_socio_activo, on: :create
  validate :ciclo_debe_estar_activo, on: :create

  private

  def valor_no_menor_al_minimo_del_ciclo
    return if valor_ahorro.blank? || ciclo.blank?

    if valor_ahorro < ciclo.ahorro_minimo
      errors.add(:valor_ahorro, "no puede ser menor al mínimo del ciclo (#{ciclo.ahorro_minimo})")
    end
  end

  def persona_debe_ser_socio_activo
    return if persona.blank?

    errors.add(:persona, "debe ser socio; los externos no ahorran") unless persona.socio?
    errors.add(:persona, "está inactiva") unless persona.activo?
  end

  def ciclo_debe_estar_activo
    return if ciclo.blank?

    errors.add(:ciclo, "debe estar activo") unless ciclo.activo?
  end
end
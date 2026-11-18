require "test_helper"

class InscripcionTest < ActiveSupport::TestCase
  setup do
    @persona = Persona.create!(nombre: "Ana Pérez", documento: "1001", celular: "3001234567")
    @ciclo = Ciclo.create!(nombre: "Ciclo 2026",
                           fecha_inicio: Date.new(2026, 1, 1),
                           fecha_fin: Date.new(2026, 12, 31))
  end

  def inscripcion_valida(atributos = {})
    Inscripcion.new({ persona: @persona, ciclo: @ciclo,
                      valor_ahorro: 100_000, periodicidad: :quincenal }.merge(atributos))
  end

  test "es válida con datos correctos" do
    assert inscripcion_valida.valid?
  end

  test "por defecto es quincenal y activa" do
    inscripcion = Inscripcion.new
    assert inscripcion.quincenal?
    assert inscripcion.activa?
  end

  test "rechaza un valor menor al mínimo del ciclo" do
    inscripcion = inscripcion_valida(valor_ahorro: 99_999)
    assert_not inscripcion.valid?
    assert inscripcion.errors[:valor_ahorro].any?
  end

  test "acepta un valor igual al mínimo del ciclo" do
    assert inscripcion_valida(valor_ahorro: 100_000).valid?
  end

  test "usa el mínimo configurado en el ciclo y no uno fijo" do
    @ciclo.update!(ahorro_minimo: 200_000)
    assert_not inscripcion_valida(valor_ahorro: 150_000).valid?
    assert inscripcion_valida(valor_ahorro: 200_000).valid?
  end

  test "rechaza personas externas" do
    externa = Persona.create!(nombre: "Luis Gómez", documento: "2002",
                              celular: "3109876543", tipo: :externo)
    inscripcion = inscripcion_valida(persona: externa)
    assert_not inscripcion.valid?
    assert inscripcion.errors[:persona].any?
  end

  test "rechaza personas inactivas" do
    @persona.update!(activo: false)
    inscripcion = inscripcion_valida
    assert_not inscripcion.valid?
    assert inscripcion.errors[:persona].any?
  end

  test "rechaza un ciclo cerrado" do
    @ciclo.cerrado!
    inscripcion = inscripcion_valida
    assert_not inscripcion.valid?
    assert inscripcion.errors[:ciclo].any?
  end

  test "una persona puede tener varias inscripciones en el mismo ciclo" do
    inscripcion_valida.save!
    inscripcion_valida(valor_ahorro: 300_000, periodicidad: :mensual).save!
    assert_equal 2, @persona.inscripciones.count
  end

  test "cerrar el ciclo no invalida las inscripciones existentes" do
    inscripcion = inscripcion_valida
    inscripcion.save!
    @ciclo.cerrado!
    assert inscripcion.reload.valid?
  end
end
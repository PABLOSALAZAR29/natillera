require "test_helper"

class CicloTest < ActiveSupport::TestCase
  def ciclo_valido(atributos = {})
    Ciclo.new({ nombre: "Ciclo 2026",
                fecha_inicio: Date.new(2026, 1, 1),
                fecha_fin: Date.new(2026, 12, 31) }.merge(atributos))
  end

  test "es válido con datos correctos" do
    assert ciclo_valido.valid?
  end

  test "requiere nombre" do
    ciclo = ciclo_valido(nombre: "")
    assert_not ciclo.valid?
    assert ciclo.errors[:nombre].any?
  end

  test "usa los valores por defecto del negocio" do
    ciclo = Ciclo.new
    assert_equal 100_000, ciclo.ahorro_minimo
    assert_equal 10, ciclo.tasa_prestamo
    assert_equal 1_000, ciclo.multa_diaria
    assert_equal 2, ciclo.dias_gracia
    assert ciclo.activo?
  end

  test "la fecha de fin debe ser posterior a la de inicio" do
    ciclo = ciclo_valido(fecha_inicio: Date.new(2026, 12, 31), fecha_fin: Date.new(2026, 1, 1))
    assert_not ciclo.valid?
    assert ciclo.errors[:fecha_fin].any?
  end

  test "el ahorro mínimo debe ser mayor a cero" do
    ciclo = ciclo_valido(ahorro_minimo: 0)
    assert_not ciclo.valid?
    assert ciclo.errors[:ahorro_minimo].any?
  end

  test "la multa diaria no puede ser negativa" do
    ciclo = ciclo_valido(multa_diaria: -1)
    assert_not ciclo.valid?
    assert ciclo.errors[:multa_diaria].any?
  end

  test "no permite dos ciclos activos a la vez" do
    ciclo_valido.save!
    segundo = ciclo_valido(nombre: "Ciclo 2027")
    assert_not segundo.valid?
    assert segundo.errors[:estado].any?
  end

  test "permite un ciclo nuevo cuando el anterior está cerrado" do
    anterior = ciclo_valido
    anterior.save!
    anterior.cerrado!

    assert ciclo_valido(nombre: "Ciclo 2027").valid?
  end

  test "se puede editar el ciclo activo sin chocar consigo mismo" do
    ciclo = ciclo_valido
    ciclo.save!
    ciclo.nombre = "Ciclo 2026 corregido"
    assert ciclo.valid?
  end
end
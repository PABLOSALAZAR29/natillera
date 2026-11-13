require "test_helper"

class PersonaTest < ActiveSupport::TestCase
  # Método de ayuda: devuelve una persona con datos válidos.
  # Cada test cambia solo lo que quiere probar.
  def persona_valida(atributos = {})
    Persona.new({ nombre: "Ana Pérez", documento: "1001", celular: "3001234567" }.merge(atributos))
  end

  test "es válida con datos correctos" do
    assert persona_valida.valid?
  end

  test "requiere nombre" do
    persona = persona_valida(nombre: "")
    assert_not persona.valid?
    assert persona.errors[:nombre].any?
  end

  test "requiere documento" do
    persona = persona_valida(documento: "")
    assert_not persona.valid?
    assert persona.errors[:documento].any?
  end

  test "requiere celular" do
    persona = persona_valida(celular: "")
    assert_not persona.valid?
    assert persona.errors[:celular].any?
  end

  test "rechaza celular con menos de 10 dígitos" do
    persona = persona_valida(celular: "300123")
    assert_not persona.valid?
    assert persona.errors[:celular].any?
  end

  test "rechaza celular con letras" do
    persona = persona_valida(celular: "300abc4567")
    assert_not persona.valid?
    assert persona.errors[:celular].any?
  end

  test "no permite documento repetido" do
    persona_valida.save!
    repetida = persona_valida(nombre: "Otra Persona")
    assert_not repetida.valid?
    assert repetida.errors[:documento].any?
  end

  test "quita espacios al inicio y al final" do
    persona = persona_valida(nombre: "  Ana Pérez  ", documento: " 1001 ")
    persona.valid?
    assert_equal "Ana Pérez", persona.nombre
    assert_equal "1001", persona.documento
  end

  test "por defecto es socio y está activa" do
    persona = Persona.new
    assert persona.socio?
    assert persona.activo?
  end

  test "puede ser externa" do
    persona = persona_valida(tipo: :externo)
    assert persona.externo?
  end
end
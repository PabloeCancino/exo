/-
  basic_proofs.lean
  Pruebas Básicas en Lean 4 / Basic Proofs in Lean 4
  
  Este archivo contiene ejemplos fundamentales para aprender
  la sintaxis de Lean 4 y cómo construir pruebas simples.
  
  This file contains fundamental examples to learn
  Lean 4 syntax and how to build simple proofs.
-/

-- ============================================
-- SECCIÓN 1: DEFINICIONES BÁSICAS
-- SECTION 1: BASIC DEFINITIONS
-- ============================================

-- Definir una constante / Define a constant
def miNumero : Nat := 42

-- Definir una función simple / Define a simple function
def duplicar (n : Nat) : Nat := n + n

-- Función con múltiples argumentos / Function with multiple arguments
def suma (a b : Nat) : Nat := a + b

-- Función recursiva: factorial / Recursive function: factorial
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

-- Verificar con #eval / Verify with #eval
#eval miNumero        -- 42
#eval duplicar 5      -- 10
#eval suma 3 4        -- 7
#eval factorial 5     -- 120

-- ============================================
-- SECCIÓN 2: TIPOS Y ESTRUCTURAS
-- SECTION 2: TYPES AND STRUCTURES
-- ============================================

-- Estructura para representar un punto 2D
-- Structure to represent a 2D point
structure Punto where
  x : Float
  y : Float
  deriving Repr

-- Crear instancias / Create instances
def origen : Punto := { x := 0.0, y := 0.0 }
def punto1 : Punto := ⟨3.0, 4.0⟩

-- Función que opera sobre la estructura
-- Function that operates on the structure
def distanciaAlOrigen (p : Punto) : Float :=
  Float.sqrt (p.x * p.x + p.y * p.y)

#eval distanciaAlOrigen punto1  -- 5.0

-- Tipo inductivo: Lista personalizada
-- Inductive type: Custom list
inductive MiLista (α : Type) where
  | vacia : MiLista α
  | cons : α → MiLista α → MiLista α
  deriving Repr

-- Ejemplos de listas / List examples
def lista1 : MiLista Nat := MiLista.cons 1 (MiLista.cons 2 MiLista.vacia)

-- ============================================
-- SECCIÓN 3: PRUEBAS SIMPLES
-- SECTION 3: SIMPLE PROOFS
-- ============================================

-- Prueba por reflexividad: 2 + 2 = 4
-- Proof by reflexivity: 2 + 2 = 4
example : 2 + 2 = 4 := rfl

-- Prueba de igualdad con variables
-- Proof of equality with variables
example (n : Nat) : n + 0 = n := Nat.add_zero n

-- Conmutatividad de la suma
-- Commutativity of addition
example (a b : Nat) : a + b = b + a := Nat.add_comm a b

-- Asociatividad de la suma
-- Associativity of addition
example (a b c : Nat) : (a + b) + c = a + (b + c) := Nat.add_assoc a b c

-- ============================================
-- SECCIÓN 4: TEOREMAS CON NOMBRE
-- SECTION 4: NAMED THEOREMS
-- ============================================

-- Teorema: 0 es elemento neutro a la izquierda
-- Theorem: 0 is left identity element
theorem cero_suma (n : Nat) : 0 + n = n := Nat.zero_add n

-- Teorema: Doble es lo mismo que multiplicar por 2
-- Theorem: Double is the same as multiplying by 2
theorem doble_es_dosPor (n : Nat) : duplicar n = 2 * n := by
  -- Expandir la definición de duplicar
  unfold duplicar
  -- Ahora tenemos: n + n = 2 * n
  -- Usar propiedades aritméticas
  omega

-- ============================================
-- SECCIÓN 5: TÁCTICAS BÁSICAS
-- SECTION 5: BASIC TACTICS
-- ============================================

-- Ejemplo usando 'intro' para introducir hipótesis
-- Example using 'intro' to introduce hypotheses
theorem implicacion_trivial (P Q : Prop) : P → (Q → P) := by
  intro hp    -- Introducimos hipótesis P
  intro _     -- Introducimos Q (no la usamos)
  exact hp    -- La conclusión es exactamente hp

-- Ejemplo usando 'apply'
-- Example using 'apply'
theorem transitividad (P Q R : Prop) : (P → Q) → (Q → R) → P → R := by
  intro hpq   -- P → Q
  intro hqr   -- Q → R
  intro hp    -- P
  apply hqr   -- Basta probar Q
  apply hpq   -- Basta probar P
  exact hp    -- Tenemos P

-- Ejemplo usando 'constructor' para conjunción
-- Example using 'constructor' for conjunction
theorem y_introduccion (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor
  · exact hp
  · exact hq

-- Ejemplo usando 'cases' para disyunción
-- Example using 'cases' for disjunction
theorem o_eliminacion (P Q R : Prop) (h : P ∨ Q) (hpr : P → R) (hqr : Q → R) : R := by
  cases h with
  | inl hp => exact hpr hp  -- Caso P
  | inr hq => exact hqr hq  -- Caso Q

-- ============================================
-- SECCIÓN 6: INDUCCIÓN
-- SECTION 6: INDUCTION
-- ============================================

-- Definir suma hasta n / Define sum up to n
def sumaHasta : Nat → Nat
  | 0 => 0
  | n + 1 => (n + 1) + sumaHasta n

-- Probar propiedad por inducción
-- Prove property by induction
theorem suma_formula (n : Nat) : 2 * sumaHasta n = n * (n + 1) := by
  induction n with
  | zero =>
    -- Caso base: 2 * sumaHasta 0 = 0 * (0 + 1)
    simp [sumaHasta]
  | succ n ih =>
    -- Paso inductivo
    simp only [sumaHasta]
    -- ih: 2 * sumaHasta n = n * (n + 1)
    ring_nf
    omega

-- ============================================
-- SECCIÓN 7: EXPLORANDO LEAN
-- SECTION 7: EXPLORING LEAN
-- ============================================

-- Usar #check para ver tipos
-- Use #check to see types
#check Nat.add_comm  -- ∀ (n m : Nat), n + m = m + n
#check @List.append  -- Ver tipo de append

-- Usar #print para ver definiciones
-- Use #print to see definitions
#print Nat.add

-- Mensajes personalizados con #check
#check (rfl : 1 + 1 = 2)

-- ============================================
-- FIN DEL ARCHIVO / END OF FILE
-- ============================================

-- ¡Felicidades! Has completado los ejemplos básicos.
-- Continúa con natural_numbers.lean y logic_examples.lean
-- 
-- Congratulations! You've completed the basic examples.
-- Continue with natural_numbers.lean and logic_examples.lean

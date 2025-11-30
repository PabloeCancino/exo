/-
  natural_numbers.lean
  Trabajando con Números Naturales en Lean 4
  Working with Natural Numbers in Lean 4
  
  Este archivo contiene ejemplos de cómo trabajar con
  números naturales, incluyendo definiciones recursivas,
  propiedades y pruebas por inducción.
  
  This file contains examples of working with
  natural numbers, including recursive definitions,
  properties, and proofs by induction.
-/

-- ============================================
-- SECCIÓN 1: DEFINICIONES RECURSIVAS
-- SECTION 1: RECURSIVE DEFINITIONS
-- ============================================

-- Suma definida manualmente (para aprender)
-- Manually defined addition (for learning)
def miSuma : Nat → Nat → Nat
  | m, 0 => m
  | m, Nat.succ n => Nat.succ (miSuma m n)

-- Multiplicación definida manualmente
-- Manually defined multiplication
def miMult : Nat → Nat → Nat
  | _, 0 => 0
  | m, Nat.succ n => miSuma m (miMult m n)

-- Potencia / Power
def potencia : Nat → Nat → Nat
  | _, 0 => 1
  | base, Nat.succ exp => miMult base (potencia base exp)

-- Verificar / Verify
#eval miSuma 3 4      -- 7
#eval miMult 3 4      -- 12
#eval potencia 2 10   -- 1024

-- Fibonacci / Fibonacci
def fibonacci : Nat → Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => fibonacci (n + 1) + fibonacci n

#eval fibonacci 10  -- 55

-- ============================================
-- SECCIÓN 2: PROPIEDADES BÁSICAS
-- SECTION 2: BASIC PROPERTIES
-- ============================================

-- Cero es neutro a la derecha / Zero is right identity
theorem suma_cero (n : Nat) : n + 0 = n := rfl

-- Cero es neutro a la izquierda / Zero is left identity
theorem cero_suma (n : Nat) : 0 + n = n := Nat.zero_add n

-- Sucesor se distribuye / Successor distributes
theorem succ_suma (m n : Nat) : Nat.succ m + n = Nat.succ (m + n) := 
  Nat.succ_add m n

-- ============================================
-- SECCIÓN 3: PRUEBAS POR INDUCCIÓN
-- SECTION 3: PROOFS BY INDUCTION
-- ============================================

-- Probar conmutatividad de miSuma
-- Prove commutativity of miSuma
theorem miSuma_comm (m n : Nat) : miSuma m n = miSuma n m := by
  induction n with
  | zero =>
    induction m with
    | zero => rfl
    | succ m ih =>
      simp only [miSuma]
      rw [← ih]
      rfl
  | succ n ih =>
    simp only [miSuma]
    rw [ih]
    induction m with
    | zero =>
      simp only [miSuma]
    | succ m ihm =>
      simp only [miSuma]
      rw [← ihm]
      rfl

-- Probar que miSuma produce el mismo resultado que +
-- Prove that miSuma produces same result as +
theorem miSuma_es_add (m n : Nat) : miSuma m n = m + n := by
  induction n with
  | zero =>
    simp only [miSuma]
    rfl
  | succ n ih =>
    simp only [miSuma]
    rw [ih]
    rfl

-- ============================================
-- SECCIÓN 4: COMPARACIONES
-- SECTION 4: COMPARISONS
-- ============================================

-- Definir "menor o igual" manualmente
-- Define "less than or equal" manually
def menorOIgual : Nat → Nat → Bool
  | 0, _ => true
  | Nat.succ _, 0 => false
  | Nat.succ m, Nat.succ n => menorOIgual m n

-- Verificar / Verify
#eval menorOIgual 3 5  -- true
#eval menorOIgual 5 3  -- false
#eval menorOIgual 3 3  -- true

-- Máximo / Maximum
def maximo : Nat → Nat → Nat
  | 0, n => n
  | m, 0 => m
  | Nat.succ m, Nat.succ n => Nat.succ (maximo m n)

-- Mínimo / Minimum
def minimo : Nat → Nat → Nat
  | 0, _ => 0
  | _, 0 => 0
  | Nat.succ m, Nat.succ n => Nat.succ (minimo m n)

#eval maximo 3 7  -- 7
#eval minimo 3 7  -- 3

-- ============================================
-- SECCIÓN 5: DIVISIBILIDAD
-- SECTION 5: DIVISIBILITY
-- ============================================

-- Definir divisibilidad / Define divisibility
def divide (d n : Nat) : Prop := ∃ k, n = d * k

-- Notación / Notation
notation:50 d " | " n => divide d n

-- Probar que 1 divide a todo número
-- Prove that 1 divides every number
theorem uno_divide (n : Nat) : 1 | n := by
  use n
  simp [Nat.one_mul]

-- Probar que todo número divide a 0
-- Prove that every number divides 0
theorem divide_cero (n : Nat) : n | 0 := by
  use 0
  simp

-- ============================================
-- SECCIÓN 6: PARIDAD
-- SECTION 6: PARITY
-- ============================================

-- Definir par e impar / Define even and odd
def esPar : Nat → Bool
  | 0 => true
  | 1 => false
  | n + 2 => esPar n

def esImpar (n : Nat) : Bool := !esPar n

#eval esPar 10   -- true
#eval esPar 7    -- false
#eval esImpar 7  -- true

-- Versión proposicional / Propositional version
def Par (n : Nat) : Prop := ∃ k, n = 2 * k
def Impar (n : Nat) : Prop := ∃ k, n = 2 * k + 1

-- Probar que 0 es par / Prove that 0 is even
theorem cero_es_par : Par 0 := by
  use 0
  rfl

-- Probar que 1 es impar / Prove that 1 is odd
theorem uno_es_impar : Impar 1 := by
  use 0
  rfl

-- Par + Par = Par
theorem par_mas_par (m n : Nat) (hm : Par m) (hn : Par n) : Par (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨j, hj⟩ := hn
  use k + j
  rw [hk, hj]
  ring

-- ============================================
-- SECCIÓN 7: MÁXIMO COMÚN DIVISOR (EUCLIDES)
-- SECTION 7: GREATEST COMMON DIVISOR (EUCLID)
-- ============================================

-- Algoritmo de Euclides / Euclid's algorithm
def mcd : Nat → Nat → Nat
  | 0, n => n
  | m + 1, n => mcd (n % (m + 1)) (m + 1)

#eval mcd 48 18   -- 6
#eval mcd 100 35  -- 5
#eval mcd 17 13   -- 1 (coprimos)

-- Mínimo común múltiplo / Least common multiple
def mcm (m n : Nat) : Nat :=
  if m = 0 ∨ n = 0 then 0
  else (m * n) / mcd m n

#eval mcm 4 6   -- 12
#eval mcm 3 5   -- 15

-- ============================================
-- SECCIÓN 8: NÚMEROS PRIMOS
-- SECTION 8: PRIME NUMBERS
-- ============================================

-- Verificar si n divide a m
def dividesBool (d m : Nat) : Bool :=
  m % d = 0

-- Verificar si es primo (versión simple)
def esPrimo (n : Nat) : Bool :=
  if n < 2 then false
  else
    let rec aux (d : Nat) : Bool :=
      if d * d > n then true
      else if dividesBool d n then false
      else aux (d + 1)
    aux 2

#eval esPrimo 2   -- true
#eval esPrimo 17  -- true
#eval esPrimo 18  -- false
#eval esPrimo 97  -- true

-- Lista de primos hasta n / List of primes up to n
def primosHasta (n : Nat) : List Nat :=
  (List.range (n + 1)).filter esPrimo

#eval primosHasta 30  -- [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

-- ============================================
-- FIN DEL ARCHIVO / END OF FILE
-- ============================================

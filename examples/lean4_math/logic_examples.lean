/-
  logic_examples.lean
  Lógica Proposicional y de Predicados en Lean 4
  Propositional and Predicate Logic in Lean 4
  
  Este archivo contiene ejemplos de lógica formal,
  incluyendo conectivos lógicos, cuantificadores y
  pruebas usando tácticas.
  
  This file contains examples of formal logic,
  including logical connectives, quantifiers, and
  proofs using tactics.
-/

-- ============================================
-- SECCIÓN 1: LÓGICA PROPOSICIONAL BÁSICA
-- SECTION 1: BASIC PROPOSITIONAL LOGIC
-- ============================================

-- Variables proposicionales / Propositional variables
variable (P Q R : Prop)

-- Implicación: P → P (identidad)
-- Implication: P → P (identity)
theorem identidad : P → P := fun hp => hp

-- Usando tácticas / Using tactics
theorem identidad' : P → P := by
  intro hp
  exact hp

-- K combinator: P → Q → P
theorem constante : P → Q → P := fun hp _ => hp

theorem constante' : P → Q → P := by
  intro hp
  intro _
  exact hp

-- Transitividad de implicación
-- Transitivity of implication
theorem imp_trans : (P → Q) → (Q → R) → (P → R) := by
  intro hpq hqr hp
  exact hqr (hpq hp)

-- ============================================
-- SECCIÓN 2: CONJUNCIÓN (AND)
-- SECTION 2: CONJUNCTION (AND)
-- ============================================

-- Introducción de conjunción / Conjunction introduction
theorem and_intro (hp : P) (hq : Q) : P ∧ Q := ⟨hp, hq⟩

theorem and_intro' (hp : P) (hq : Q) : P ∧ Q := by
  constructor
  · exact hp
  · exact hq

-- Eliminación izquierda / Left elimination
theorem and_left (h : P ∧ Q) : P := h.1

theorem and_left' (h : P ∧ Q) : P := by
  obtain ⟨hp, _⟩ := h
  exact hp

-- Eliminación derecha / Right elimination
theorem and_right (h : P ∧ Q) : Q := h.2

-- Conmutatividad / Commutativity
theorem and_comm : P ∧ Q ↔ Q ∧ P := by
  constructor
  · intro ⟨hp, hq⟩
    exact ⟨hq, hp⟩
  · intro ⟨hq, hp⟩
    exact ⟨hp, hq⟩

-- Asociatividad / Associativity
theorem and_assoc : (P ∧ Q) ∧ R ↔ P ∧ (Q ∧ R) := by
  constructor
  · intro ⟨⟨hp, hq⟩, hr⟩
    exact ⟨hp, hq, hr⟩
  · intro ⟨hp, hq, hr⟩
    exact ⟨⟨hp, hq⟩, hr⟩

-- ============================================
-- SECCIÓN 3: DISYUNCIÓN (OR)
-- SECTION 3: DISJUNCTION (OR)
-- ============================================

-- Introducción izquierda / Left introduction
theorem or_inl (hp : P) : P ∨ Q := Or.inl hp

-- Introducción derecha / Right introduction
theorem or_inr (hq : Q) : P ∨ Q := Or.inr hq

-- Eliminación / Elimination
theorem or_elim (h : P ∨ Q) (hpr : P → R) (hqr : Q → R) : R := by
  cases h with
  | inl hp => exact hpr hp
  | inr hq => exact hqr hq

-- Conmutatividad / Commutativity
theorem or_comm : P ∨ Q ↔ Q ∨ P := by
  constructor
  · intro h
    cases h with
    | inl hp => right; exact hp
    | inr hq => left; exact hq
  · intro h
    cases h with
    | inl hq => right; exact hq
    | inr hp => left; exact hp

-- Distributividad / Distributivity
theorem and_or_distrib : P ∧ (Q ∨ R) ↔ (P ∧ Q) ∨ (P ∧ R) := by
  constructor
  · intro ⟨hp, hqr⟩
    cases hqr with
    | inl hq => left; exact ⟨hp, hq⟩
    | inr hr => right; exact ⟨hp, hr⟩
  · intro h
    cases h with
    | inl hpq => exact ⟨hpq.1, Or.inl hpq.2⟩
    | inr hpr => exact ⟨hpr.1, Or.inr hpr.2⟩

-- ============================================
-- SECCIÓN 4: NEGACIÓN
-- SECTION 4: NEGATION
-- ============================================

-- Definición: ¬P significa P → False
-- Definition: ¬P means P → False

-- Introducción de negación / Negation introduction
theorem neg_intro (h : P → False) : ¬P := h

-- Eliminación (modus tollens)
theorem modus_tollens (hpq : P → Q) (hnq : ¬Q) : ¬P := by
  intro hp
  exact hnq (hpq hp)

-- Doble negación (introducción)
-- Double negation (introduction)
theorem double_neg_intro : P → ¬¬P := by
  intro hp hnp
  exact hnp hp

-- Ley de contraposición / Contraposition law
theorem contraposition : (P → Q) → (¬Q → ¬P) := by
  intro hpq hnq hp
  exact hnq (hpq hp)

-- ============================================
-- SECCIÓN 5: LEYES DE DE MORGAN
-- SECTION 5: DE MORGAN'S LAWS
-- ============================================

-- ¬(P ∨ Q) ↔ ¬P ∧ ¬Q
theorem de_morgan_or : ¬(P ∨ Q) ↔ ¬P ∧ ¬Q := by
  constructor
  · intro h
    constructor
    · intro hp
      apply h
      left
      exact hp
    · intro hq
      apply h
      right
      exact hq
  · intro ⟨hnp, hnq⟩ hpq
    cases hpq with
    | inl hp => exact hnp hp
    | inr hq => exact hnq hq

-- ¬(P ∧ Q) ← ¬P ∨ ¬Q (esta dirección es siempre válida)
theorem de_morgan_and_rev : ¬P ∨ ¬Q → ¬(P ∧ Q) := by
  intro h ⟨hp, hq⟩
  cases h with
  | inl hnp => exact hnp hp
  | inr hnq => exact hnq hq

-- ============================================
-- SECCIÓN 6: BICONDICIONAL (IFF)
-- SECTION 6: BICONDITIONAL (IFF)
-- ============================================

-- P ↔ Q significa (P → Q) ∧ (Q → P)
-- P ↔ Q means (P → Q) ∧ (Q → P)

-- Introducción / Introduction
theorem iff_intro (hpq : P → Q) (hqp : Q → P) : P ↔ Q := ⟨hpq, hqp⟩

theorem iff_intro' (hpq : P → Q) (hqp : Q → P) : P ↔ Q := by
  constructor
  · exact hpq
  · exact hqp

-- Reflexividad / Reflexivity
theorem iff_refl : P ↔ P := ⟨id, id⟩

-- Simetría / Symmetry
theorem iff_symm : (P ↔ Q) → (Q ↔ P) := by
  intro ⟨hpq, hqp⟩
  exact ⟨hqp, hpq⟩

-- Transitividad / Transitivity
theorem iff_trans : (P ↔ Q) → (Q ↔ R) → (P ↔ R) := by
  intro ⟨hpq, hqp⟩ ⟨hqr, hrq⟩
  constructor
  · intro hp
    exact hqr (hpq hp)
  · intro hr
    exact hqp (hrq hr)

-- ============================================
-- SECCIÓN 7: CUANTIFICADOR UNIVERSAL (∀)
-- SECTION 7: UNIVERSAL QUANTIFIER (∀)
-- ============================================

-- Introducción: probar para un elemento arbitrario
-- Introduction: prove for an arbitrary element
theorem forall_intro : ∀ n : Nat, n + 0 = n := by
  intro n
  rfl

-- Eliminación: instanciar con un valor específico
-- Elimination: instantiate with a specific value
theorem forall_elim (h : ∀ n : Nat, n + 0 = n) : 5 + 0 = 5 := h 5

-- Ejemplo con predicado / Example with predicate
def esPositivo (n : Nat) : Prop := n > 0

theorem succ_positivo : ∀ n : Nat, esPositivo (n + 1) := by
  intro n
  unfold esPositivo
  omega

-- ============================================
-- SECCIÓN 8: CUANTIFICADOR EXISTENCIAL (∃)
-- SECTION 8: EXISTENTIAL QUANTIFIER (∃)
-- ============================================

-- Introducción: dar un testigo
-- Introduction: provide a witness
theorem exists_intro : ∃ n : Nat, n > 5 := by
  use 10
  omega

-- Otra forma / Another way
theorem exists_intro' : ∃ n : Nat, n * n = 4 := ⟨2, rfl⟩

-- Eliminación: usar el testigo
-- Elimination: use the witness
theorem exists_elim (h : ∃ n : Nat, n > 5) : ∃ m : Nat, m > 3 := by
  obtain ⟨n, hn⟩ := h
  use n
  omega

-- ============================================
-- SECCIÓN 9: COMBINANDO CUANTIFICADORES
-- SECTION 9: COMBINING QUANTIFIERS
-- ============================================

-- ∀x∃y vs ∃y∀x
-- Nota: estas no son equivalentes en general
-- Note: these are not equivalent in general

-- Si ∀x∃y P(x,y), entonces puede que no haya un y que funcione para todos
-- If ∀x∃y P(x,y), there might not be a y that works for all

-- Ejemplo donde sí se puede intercambiar
-- Example where they can be swapped
theorem cuant_ejemplo : (∀ n : Nat, ∃ m : Nat, m > n) := by
  intro n
  use n + 1
  omega

-- ============================================
-- SECCIÓN 10: LÓGICA CLÁSICA
-- SECTION 10: CLASSICAL LOGIC
-- ============================================

-- En lógica constructiva, algunas cosas no son demostrables
-- In constructive logic, some things are not provable
-- Pero podemos usar `Classical` para lógica clásica
-- But we can use `Classical` for classical logic

-- Tercero excluido / Law of excluded middle
-- (Requiere axioma clásico / Requires classical axiom)
open Classical in
theorem excluded_middle : P ∨ ¬P := em P

-- Doble negación eliminación / Double negation elimination
-- (También requiere axioma clásico / Also requires classical axiom)
open Classical in
theorem double_neg_elim : ¬¬P → P := by
  intro hnnp
  cases em P with
  | inl hp => exact hp
  | inr hnp => exact absurd hnp hnnp

-- ============================================
-- SECCIÓN 11: EJERCICIOS PRÁCTICOS
-- SECTION 11: PRACTICE EXERCISES
-- ============================================

-- Intenta probar estos teoremas por ti mismo
-- Try to prove these theorems yourself

-- Ejercicio 1: (P ∧ Q) → P
-- Hint: usa .1 o constructor
example : (P ∧ Q) → P := by
  sorry  -- Reemplaza 'sorry' con tu prueba

-- Ejercicio 2: P → (P ∨ Q)
example : P → (P ∨ Q) := by
  sorry

-- Ejercicio 3: ¬P ∧ ¬Q → ¬(P ∨ Q)
example : ¬P ∧ ¬Q → ¬(P ∨ Q) := by
  sorry

-- Ejercicio 4: (P → Q) → (P → R) → (P → Q ∧ R)
example : (P → Q) → (P → R) → (P → Q ∧ R) := by
  sorry

-- Ejercicio 5: ∀ n : Nat, 0 ≤ n
example : ∀ n : Nat, 0 ≤ n := by
  sorry

-- ============================================
-- SOLUCIONES (NO MIRAR ANTES DE INTENTAR)
-- SOLUTIONS (DON'T LOOK BEFORE TRYING)
-- ============================================

-- Solución 1
theorem sol1 : (P ∧ Q) → P := fun h => h.1

-- Solución 2
theorem sol2 : P → (P ∨ Q) := fun hp => Or.inl hp

-- Solución 3
theorem sol3 : ¬P ∧ ¬Q → ¬(P ∨ Q) := by
  intro ⟨hnp, hnq⟩ hpq
  cases hpq with
  | inl hp => exact hnp hp
  | inr hq => exact hnq hq

-- Solución 4
theorem sol4 : (P → Q) → (P → R) → (P → Q ∧ R) := by
  intro hpq hpr hp
  exact ⟨hpq hp, hpr hp⟩

-- Solución 5
theorem sol5 : ∀ n : Nat, 0 ≤ n := by
  intro n
  exact Nat.zero_le n

-- ============================================
-- FIN DEL ARCHIVO / END OF FILE
-- ============================================

-- ¡Excelente trabajo! Has aprendido los fundamentos de la lógica en Lean 4.
-- Excellent work! You've learned the fundamentals of logic in Lean 4.

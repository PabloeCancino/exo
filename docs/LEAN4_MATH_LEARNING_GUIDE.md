# Guía para Aprender Lean 4 Math / Lean 4 Math Learning Guide

Esta guía te ayudará a comenzar con Lean 4 y Mathlib para la demostración de teoremas matemáticos y programación funcional.

This guide will help you get started with Lean 4 and Mathlib for mathematical theorem proving and functional programming.

---

## Tabla de Contenidos / Table of Contents

1. [¿Qué es Lean 4? / What is Lean 4?](#qué-es-lean-4--what-is-lean-4)
2. [Instalación / Installation](#instalación--installation)
3. [Primeros Pasos / Getting Started](#primeros-pasos--getting-started)
4. [Sintaxis Básica / Basic Syntax](#sintaxis-básica--basic-syntax)
5. [Mathlib: Biblioteca Matemática / Mathlib: Math Library](#mathlib-biblioteca-matemática--mathlib-math-library)
6. [Ejemplos de Código / Code Examples](#ejemplos-de-código--code-examples)
7. [Recursos de Aprendizaje / Learning Resources](#recursos-de-aprendizaje--learning-resources)
8. [Ruta de Aprendizaje Recomendada / Recommended Learning Path](#ruta-de-aprendizaje-recomendada--recommended-learning-path)

---

## ¿Qué es Lean 4? / What is Lean 4?

**Español:**
Lean 4 es un lenguaje de programación funcional y un asistente de pruebas interactivo. Es utilizado para:
- Demostración formal de teoremas matemáticos
- Verificación de software
- Programación funcional pura
- Formalización de matemáticas

**English:**
Lean 4 is a functional programming language and interactive theorem prover. It is used for:
- Formal mathematical theorem proving
- Software verification
- Pure functional programming
- Formalization of mathematics

---

## Instalación / Installation

### Método 1: elan (Recomendado / Recommended)

`elan` es el gestor de versiones oficial de Lean, similar a `rustup` para Rust.

```bash
# Linux/macOS
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh

# Agregar al PATH / Add to PATH
source ~/.elan/env

# Verificar instalación / Verify installation
lean --version
lake --version
```

### Windows

```powershell
# Usando PowerShell / Using PowerShell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/leanprover/elan/master/elan-init.ps1" -OutFile "elan-init.ps1"
powershell -ExecutionPolicy Bypass -File elan-init.ps1
```

### Método 2: VS Code Extension

1. Instalar [Visual Studio Code](https://code.visualstudio.com/)
2. Instalar la extensión "Lean 4" desde el marketplace
3. La extensión te guiará en la instalación de Lean 4

### Verificar Instalación / Verify Installation

```bash
# Verificar Lean / Check Lean
lean --version
# Esperado / Expected: leanprover/lean4:v4.x.x

# Verificar Lake (sistema de construcción) / Check Lake (build system)
lake --version
```

---

## Primeros Pasos / Getting Started

### Crear un Proyecto Nuevo / Create a New Project

```bash
# Crear directorio del proyecto / Create project directory
mkdir mi_proyecto_lean
cd mi_proyecto_lean

# Inicializar proyecto con Lake / Initialize project with Lake
lake init mi_proyecto

# O con Mathlib / Or with Mathlib
lake init mi_proyecto math
```

### Estructura del Proyecto / Project Structure

```
mi_proyecto/
├── lakefile.lean      # Configuración del proyecto / Project configuration
├── lake-manifest.json # Dependencias fijadas / Locked dependencies
├── lean-toolchain     # Versión de Lean / Lean version
└── MiProyecto/
    └── Basic.lean     # Tu código / Your code
```

### Tu Primer Archivo Lean / Your First Lean File

Crea un archivo `Hello.lean`:

```lean
-- Hola Mundo en Lean 4 / Hello World in Lean 4

-- Definir una constante / Define a constant
def mensaje : String := "¡Hola, Lean 4!"

-- Función principal / Main function
def main : IO Unit := do
  IO.println mensaje
  IO.println "Bienvenido a Lean 4 Math!"

-- Ejecutar: lake build && lake exe mi_proyecto
-- Run: lake build && lake exe mi_proyecto
```

---

## Sintaxis Básica / Basic Syntax

### Tipos Básicos / Basic Types

```lean
-- Números naturales / Natural numbers
def n : Nat := 42

-- Enteros / Integers
def z : Int := -7

-- Booleanos / Booleans
def b : Bool := true

-- Cadenas / Strings
def s : String := "Hola"

-- Listas / Lists
def lista : List Nat := [1, 2, 3, 4, 5]

-- Opcionales / Optionals
def quizas : Option Nat := some 5
```

### Funciones / Functions

```lean
-- Función simple / Simple function
def suma (a b : Nat) : Nat := a + b

-- Función recursiva / Recursive function
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

-- Función con pattern matching
def esPositivo : Int → Bool
  | Int.ofNat 0 => false
  | Int.ofNat (n + 1) => true
  | Int.negSucc _ => false

-- Función de orden superior / Higher-order function
def aplicarDosVeces (f : Nat → Nat) (x : Nat) : Nat := f (f x)
```

### Estructuras y Clases / Structures and Classes

```lean
-- Estructura / Structure
structure Punto where
  x : Float
  y : Float
  deriving Repr

-- Crear instancia / Create instance
def origen : Punto := { x := 0.0, y := 0.0 }
def p1 : Punto := ⟨1.0, 2.0⟩

-- Clase de tipos / Type class
class Monoid (α : Type) where
  unit : α
  op : α → α → α

instance : Monoid Nat where
  unit := 0
  op := Nat.add
```

---

## Mathlib: Biblioteca Matemática / Mathlib: Math Library

Mathlib es la biblioteca matemática principal para Lean 4, conteniendo formalizaciones de:
- Álgebra (grupos, anillos, campos)
- Análisis (cálculo, topología)
- Teoría de números
- Combinatoria
- Y mucho más

### Agregar Mathlib a tu Proyecto / Add Mathlib to Your Project

Edita tu `lakefile.lean`:

```lean
import Lake
open Lake DSL

package mi_proyecto where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4"

@[default_target]
lean_lib MiProyecto where
```

Luego ejecuta / Then run:

```bash
lake update
lake build
```

### Importar Mathlib / Import Mathlib

```lean
import Mathlib.Data.Nat.Basic
import Mathlib.Algebra.Group.Defs
import Mathlib.Tactic
```

---

## Ejemplos de Código / Code Examples

### Ejemplo 1: Prueba Simple / Simple Proof

```lean
-- Demostrar que 2 + 2 = 4
example : 2 + 2 = 4 := rfl

-- Demostrar conmutatividad de la suma
example (a b : Nat) : a + b = b + a := Nat.add_comm a b

-- Demostrar asociatividad
example (a b c : Nat) : (a + b) + c = a + (b + c) := Nat.add_assoc a b c
```

### Ejemplo 2: Teorema con Tácticas / Theorem with Tactics

```lean
import Mathlib.Tactic

-- Demostrar: Si n > 0, entonces n ≠ 0
theorem positivo_no_cero (n : Nat) (h : n > 0) : n ≠ 0 := by
  intro hn  -- Asumimos n = 0
  rw [hn] at h  -- Reescribimos en h
  -- Ahora h dice 0 > 0, lo cual es falso
  exact Nat.lt_irrefl 0 h

-- Demostración alternativa / Alternative proof
theorem positivo_no_cero' (n : Nat) (h : n > 0) : n ≠ 0 :=
  Nat.pos_iff_ne_zero.mp h
```

### Ejemplo 3: Inducción / Induction

```lean
-- Demostrar: suma de 0 a n = n * (n + 1) / 2
-- Primero definimos la suma / First define the sum
def sumaHasta : Nat → Nat
  | 0 => 0
  | n + 1 => (n + 1) + sumaHasta n

-- Teorema (simplificado) / Theorem (simplified)
theorem suma_formula (n : Nat) : 2 * sumaHasta n = n * (n + 1) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [sumaHasta]
    ring_nf
    omega
```

### Ejemplo 4: Teoría de Grupos / Group Theory

```lean
import Mathlib.Algebra.Group.Basic

-- Trabajar con grupos abstractos / Working with abstract groups
variable {G : Type*} [Group G]

-- El inverso del inverso es el elemento original
example (a : G) : (a⁻¹)⁻¹ = a := inv_inv a

-- El inverso del producto
example (a b : G) : (a * b)⁻¹ = b⁻¹ * a⁻¹ := mul_inv_rev a b

-- Demostración personalizada / Custom proof
theorem mi_teorema (a b : G) (h : a * b = 1) : b * a = 1 := by
  have : b = a⁻¹ := by
    calc b = 1 * b := by rw [one_mul]
         _ = (a⁻¹ * a) * b := by rw [inv_mul_cancel]
         _ = a⁻¹ * (a * b) := by rw [mul_assoc]
         _ = a⁻¹ * 1 := by rw [h]
         _ = a⁻¹ := by rw [mul_one]
  rw [this, mul_inv_cancel]
```

### Ejemplo 5: Lógica Proposicional / Propositional Logic

```lean
-- Demostrar: P → (Q → P)
theorem imp_intro (P Q : Prop) : P → (Q → P) := fun hp _ => hp

-- Demostrar: (P → Q) → (Q → R) → (P → R)
theorem imp_trans (P Q R : Prop) : (P → Q) → (Q → R) → (P → R) :=
  fun hpq hqr hp => hqr (hpq hp)

-- Usando tácticas / Using tactics
theorem de_morgan (P Q : Prop) : ¬(P ∨ Q) ↔ ¬P ∧ ¬Q := by
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
```

---

## Recursos de Aprendizaje / Learning Resources

### Documentación Oficial / Official Documentation

| Recurso / Resource | Enlace / Link | Descripción / Description |
|-------------------|---------------|---------------------------|
| Lean 4 Manual | https://lean-lang.org/lean4/doc/ | Manual oficial de Lean 4 |
| Theorem Proving in Lean 4 | https://lean-lang.org/theorem_proving_in_lean4/ | Libro sobre demostración de teoremas |
| Functional Programming in Lean | https://lean-lang.org/functional_programming_in_lean/ | Programación funcional en Lean |
| Mathlib Documentation | https://leanprover-community.github.io/mathlib4_docs/ | Documentación de Mathlib |

### Cursos y Tutoriales / Courses and Tutorials

| Recurso / Resource | Enlace / Link | Nivel / Level |
|-------------------|---------------|---------------|
| Mathematics in Lean | https://leanprover-community.github.io/mathematics_in_lean/ | Intermedio |
| Lean Game Server | https://adam.math.hhu.de/ | Principiante |
| Natural Number Game | https://adam.math.hhu.de/#/g/leanprover-community/NNG4 | Principiante |
| Formalising Mathematics | https://www.ma.imperial.ac.uk/~buzzard/xena/formalising-mathematics-2024/ | Avanzado |

### Comunidad / Community

- **Zulip Chat**: https://leanprover.zulipchat.com/ - Comunidad principal de Lean
- **GitHub**: https://github.com/leanprover-community - Proyectos de la comunidad
- **Stack Overflow**: Tag `lean` y `lean4`

### Libros Recomendados / Recommended Books

1. **"Theorem Proving in Lean 4"** - Documentación oficial
2. **"Mathematics in Lean"** - Por la comunidad Mathlib
3. **"The Mechanics of Proof"** - Por Heather Macbeth

---

## Ruta de Aprendizaje Recomendada / Recommended Learning Path

### Semana 1-2: Fundamentos / Foundations

1. **Instalar Lean 4** con elan y configurar VS Code
2. **Jugar Natural Number Game** (https://adam.math.hhu.de/#/g/leanprover-community/NNG4)
   - Aprende tácticas básicas: `rfl`, `rw`, `induction`
3. **Leer Capítulos 1-3** de "Theorem Proving in Lean 4"

### Semana 3-4: Sintaxis y Tipos / Syntax and Types

1. **Leer Capítulos 4-6** de "Theorem Proving in Lean 4"
2. **Practicar**:
   - Definir funciones recursivas
   - Trabajar con tipos inductivos
   - Usar pattern matching
3. **Comenzar "Mathematics in Lean"** Capítulo 1

### Semana 5-6: Tácticas / Tactics

1. **Dominar tácticas esenciales**:
   - `intro`, `apply`, `exact`
   - `have`, `let`, `calc`
   - `cases`, `induction`
   - `simp`, `ring`, `linarith`
2. **Completar "Mathematics in Lean"** Capítulos 2-3

### Semana 7-8: Mathlib Básico / Basic Mathlib

1. **Instalar y configurar Mathlib** en un proyecto
2. **Explorar estructuras algebraicas**:
   - Grupos, anillos, campos
3. **Practicar pruebas** con la biblioteca

### Semana 9+: Especialización / Specialization

Elige un área de interés:
- **Álgebra**: Teoría de grupos, anillos, módulos
- **Análisis**: Límites, continuidad, derivadas
- **Teoría de Números**: Divisibilidad, números primos
- **Topología**: Espacios topológicos, continuidad

---

## Tácticas Más Usadas / Most Used Tactics

| Táctica / Tactic | Uso / Usage |
|-----------------|-------------|
| `rfl` | Prueba por reflexividad (igualdad trivial) |
| `rw [h]` | Reescribe usando la hipótesis h |
| `simp` | Simplificación automática |
| `intro h` | Introduce una hipótesis |
| `apply f` | Aplica una función/teorema |
| `exact h` | Cierra el goal con h exactamente |
| `have h : P := ...` | Introduce una nueva hipótesis |
| `cases h` | Divide en casos |
| `induction n` | Prueba por inducción |
| `ring` | Resuelve ecuaciones de anillos |
| `linarith` | Aritmética lineal |
| `omega` | Aritmética de Presburger |
| `decide` | Decisión automática para Props decidibles |
| `norm_num` | Normalización numérica |
| `contradiction` | Encuentra contradicción |
| `constructor` | Prueba conjunción/existencial |

---

## Consejos para Principiantes / Tips for Beginners

1. **Usa el Natural Number Game** - Es la mejor manera de empezar
2. **No te frustres** - Las pruebas formales requieren práctica
3. **Lee errores cuidadosamente** - Lean da mensajes muy informativos
4. **Usa `#check` y `#print`** - Para explorar tipos y definiciones
5. **Aprende las tácticas gradualmente** - No intentes aprenderlas todas a la vez
6. **Únete al Zulip** - La comunidad es muy amigable y servicial
7. **Practica regularmente** - Incluso 30 minutos al día ayuda

```lean
-- Herramientas de exploración / Exploration tools
#check Nat.add_comm  -- Ver tipo de un término
#print Nat.add_comm  -- Ver definición
#eval 2 + 2          -- Evaluar expresión
```

---

## Contribuir a Mathlib / Contributing to Mathlib

Una vez que tengas experiencia, considera contribuir:

1. **Lee la guía de contribución**: https://leanprover-community.github.io/contribute/
2. **Comienza con issues "good first issue"**
3. **Participa en el Zulip** para obtener orientación

---

¡Buena suerte en tu viaje con Lean 4! / Good luck on your Lean 4 journey!

*Esta guía fue creada para ayudar a los usuarios del proyecto exo a aprender Lean 4 y matemáticas formales.*

*This guide was created to help exo project users learn Lean 4 and formal mathematics.*

-- lakefile.lean
-- Configuración del proyecto Lean 4 / Lean 4 Project Configuration

import Lake
open Lake DSL

package lean4_math_examples where
  -- Opciones de Lean / Lean options
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,  -- Usar notación λ bonita / Use pretty λ notation
    ⟨`autoImplicit, false⟩    -- Deshabilitar implícitos automáticos / Disable auto implicits
  ]

-- Para usar Mathlib, descomenta las siguientes líneas:
-- To use Mathlib, uncomment the following lines:
-- require mathlib from git
--   "https://github.com/leanprover-community/mathlib4"

@[default_target]
lean_lib Lean4MathExamples where
  -- Raíz de la biblioteca / Library root
  srcDir := "."

# Ejemplos de Lean 4 Math / Lean 4 Math Examples

Este directorio contiene ejemplos para ayudarte a aprender Lean 4 y matemáticas formales.

This directory contains examples to help you learn Lean 4 and formal mathematics.

## Contenido / Contents

1. **basic_proofs.lean** - Pruebas básicas y sintaxis fundamental
2. **natural_numbers.lean** - Ejemplos con números naturales
3. **logic_examples.lean** - Lógica proposicional y de predicados
4. **lakefile.lean** - Archivo de configuración del proyecto

## Cómo Usar / How to Use

### Prerequisitos / Prerequisites

1. Instalar Lean 4 y elan:
```bash
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
source ~/.elan/env
```

2. Verificar la instalación:
```bash
lean --version
lake --version
```

### Ejecutar Ejemplos / Run Examples

```bash
cd examples/lean4_math
lake build
```

### Usar en VS Code / Use in VS Code

1. Instalar la extensión "Lean 4" en VS Code
2. Abrir esta carpeta en VS Code
3. Los archivos .lean se compilarán automáticamente

## Aprende Más / Learn More

Consulta la [Guía de Aprendizaje de Lean 4 Math](../../docs/LEAN4_MATH_LEARNING_GUIDE.md) para una guía completa.

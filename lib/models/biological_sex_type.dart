/// Tipo de sexo biológico para selectores de formulario.
enum BiologicalSexType {
  male('Hombre'),
  indeterminateOrIntersex('Indeterminado o Intersexual'),
  female('Mujer');

  const BiologicalSexType(this.displayName);
  final String displayName;
}

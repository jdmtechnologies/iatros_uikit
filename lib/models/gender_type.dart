/// Tipo de género para selectores de formulario.
enum Gender {
  male('Masculino'),
  female('Femenino'),
  other('Otro');

  const Gender(this.displayName);
  final String displayName;
}

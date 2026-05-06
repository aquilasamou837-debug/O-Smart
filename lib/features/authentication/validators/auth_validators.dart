class AuthValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email requis';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Email invalide';
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Nom d\'utilisateur requis';
    if (value.trim().length < 3) return 'Minimum 3 caractères';
    if (value.trim().length > 20) return 'Maximum 20 caractères';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Mot de passe requis';
    if (value.length < 6) return 'Minimum 6 caractères';
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirme ton mot de passe';
    if (value!= password) return 'Les mots de passe ne correspondent pas';
    return null;
  }

  static String? validateLicenceKey(String? value) {
    if (value == null || value.isEmpty) return 'Clé de licence requise';
    if (value.trim().length < 8) return 'Clé invalide';
    return null;
  }
  static String? validateOtpCode(String? value) {
  if (value == null || value.isEmpty) return 'Code requis';
  if (value.length != 6) return 'Le code doit faire 6 chiffres';
  if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) return 'Code invalide';
  return null;
}
}

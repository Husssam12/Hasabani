String? requiredValidation(String? value,
    {String message = 'هذا الحقل مطلوب'}) {
  if (value?.trim().isNotEmpty ?? false) return null;
  return message;
}

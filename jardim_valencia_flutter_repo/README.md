# Jardim de Valência (Flutter + Firebase)

- Estilo visual Nothing (preto/branco, vidro).
- Login (e-mail/senha) com Firebase Auth.
- Listas de encomendas (pendentes/retiradas) por apartamento do usuário.
- Botão **Encomenda retirada** marca `picked_up` no Firestore.

## Como rodar local (opcional)
```bash
flutter pub get
flutter run
```

## Firebase
- Adicione **google-services.json** em `android/app/` (no CI é injetado via Base64).
- Habilite Auth (email/senha), Firestore, Storage.
- Estrutura sugerida:
  - `users/{uid} -> { role: 'resident'|'porter'|'admin', apartments: ['A-101'] }`
  - `packages/{id} -> { apartmentId, condoId, status, createdAt, pickedUpAt?, pickedUpBy? }`
  - `apartments/{aptId} -> { number, residents:[uid...] }`

## Build na nuvem (Codemagic)
- O arquivo `codemagic.yaml` está na raiz. Siga as variáveis descritas lá.

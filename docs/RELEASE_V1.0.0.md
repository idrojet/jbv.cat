# Release v1.0.0

Data: 14 de juliol de 2026

## Resum

Primera versió formal i estable de `jbv.cat`. Aquesta release fixa com a referència immutable el portafoli que ja estava publicat a `https://jbv.cat` i alinea el repositori font amb l'artefacte desplegat.

## Contingut públic

El portafoli inclou informació pública de tres projectes reals:

1. `jbv.cat`;
2. `lillet-display`;
3. `agendacoffee`.

Els dos projectes d'exemple de la versió inicial s'han retirat. Els repositoris de `lillet-display` i `agendacoffee` continuen indicats com a privats i no se'n publica el codi.

## Canvis de consolidació

- Font pública alineada amb `jbv.cat-deploy` i producció.
- Versió del paquet establerta a `1.0.0`.
- README actualitzat com a document d'entrada del projecte.
- Pla viu de millores creat a `docs/PLA_MILLORES.md`.
- Procediment operatiu creat a `docs/DESPLEGAMENT.md`.
- Preparació reproduïble del deploy amb `scripts/prepara-deploy.sh`.
- Test automatitzat de generació, paritat i fronteres de seguretat.
- Ús de `rsync --delete` restringit al destí canònic `jbv.cat-deploy`.
- Mode alternatiu `--prepare-new` limitat a carpetes noves o buides i sense eliminació.

## Verificació

Abans del tancament s'ha comprovat:

- `npm test`;
- `npm run deploy:check`;
- sintaxi Bash;
- sintaxi JavaScript;
- validesa de `package.json` i `package-lock.json`;
- `git diff --check`;
- absència d'espais finals als fitxers modificats;
- paritat exacta entre la font pública i `jbv.cat-deploy`;
- coincidència byte a byte dels 21 fitxers públics coneguts amb producció;
- revisió independent final aprovada sense bloquejants.

## Desplegament

Aquesta release no requereix canviar el contingut públic de CDmon: els fitxers públics de `v1.0.0` coincideixen amb els que ja serveix producció.

El mecanisme concret de transferència a CDmon i la capacitat de rollback del proveïdor continuen pendents de confirmació i estan marcats al pla de millores.

## Rollback

El tag anotat `v1.0.0` és la referència immutable del baseline. Per recuperar-la:

1. obtenir `v1.0.0` en una còpia de treball separada;
2. executar `npm test`;
3. preparar un artefacte amb l'script versionat;
4. transferir-lo a CDmon mitjançant el procediment confirmat;
5. verificar `https://jbv.cat`.

No s'ha de moure ni reescriure el tag publicat.

## Limitacions conegudes

Les millores de contingut, accessibilitat, SEO, rendiment, domini `www`, capçaleres HTTP i automatització completa del procés de publicació queden planificades per a versions posteriors, començant per la línia `1.1`.

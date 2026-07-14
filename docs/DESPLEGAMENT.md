# Desplegament de jbv.cat

> Procediment operatiu per preparar i verificar l'artefacte publicable.
>
> Última revisió: 14 de juliol de 2026

## 1. Model actual

El projecte manté separades dues carpetes:

- font versionada: `/home/jordi/projectes/jbv.cat`;
- artefacte publicable: `/home/jordi/projectes/jbv.cat-deploy`.

La producció és un web estàtic servit per Apache a CDmon. La carpeta de deploy no és un repositori Git i no s'ha d'editar manualment.

No s'ha identificat cap desplegament automàtic associat a un push a GitHub. El canal concret utilitzat per transferir els fitxers a CDmon —panell, FTP, SFTP o un altre mecanisme— encara s'ha de confirmar abans de la publicació següent.

## 2. Fitxers públics

Només formen part del deploy:

```text
index.html
privadesa.html
assets/
css/
js/
```

Queden fora del deploy, entre altres:

- `.git/`;
- `node_modules/`;
- `docs/`;
- `scripts/`;
- `tests/`;
- `README.md`;
- `package.json` i `package-lock.json`;
- eines locals de generació d'icones.

## 3. Comprovacions abans de preparar-lo

Des de `/home/jordi/projectes/jbv.cat`:

```bash
git status --short --branch
npm test
```

Resultat esperat del test:

```text
OK: preparació segura i comprovació del deploy
```

Abans d'una publicació formal també cal revisar:

- el diff complet de Git;
- el contingut de `js/projects.js`;
- la portada i la pàgina de privadesa en local;
- que no hi hagi secrets ni fitxers locals entre els canvis.

## 4. Preparar la carpeta de deploy

```bash
npm run deploy:prepare
```

L'ordre crea una còpia temporal només amb els fitxers públics i la sincronitza amb:

```text
/home/jordi/projectes/jbv.cat-deploy
```

La sincronització utilitza eliminació controlada: qualsevol fitxer que hi hagi al destí canònic i que no formi part de l'artefacte públic serà eliminat. L'ús de `rsync --delete` està restringit estrictament a `/home/jordi/projectes/jbv.cat-deploy`; el mode normal no accepta cap destí alternatiu.

Per preparar un destí alternatiu cal indicar `--prepare-new`, que només accepta una carpeta nova o buida i no utilitza `--delete`:

```bash
scripts/prepara-deploy.sh --prepare-new /ruta/destí
```

Si el destí alternatiu conté qualsevol fitxer, l'ordre falla sense modificar-lo.

### Prerequisits locals

- Linux o WSL;
- Bash;
- `rsync`;
- Node.js 18.17 o posterior i npm per executar les ordres `npm run` i les eines locals;
- utilitats estàndard `cp`, `diff`, `cmp` i `mktemp`.

## 5. Comprovar que font i deploy coincideixen

```bash
npm run deploy:check
```

Resultat esperat:

```text
OK: el deploy coincideix amb la font pública
```

Aquesta comprovació és de només lectura i falla si falta, sobra o difereix qualsevol fitxer publicable.

Per comprovar un destí alternatiu:

```bash
scripts/prepara-deploy.sh --check /ruta/destí
```

## 6. Publicació a CDmon

Abans d'executar aquest apartat cal confirmar i documentar el mecanisme real d'accés a CDmon.

Seqüència prevista:

1. Fer una còpia de seguretat o confirmar que es pot recuperar la versió publicada anterior.
2. Transferir el contingut de `jbv.cat-deploy/` a l'arrel pública del domini.
3. No transferir la carpeta contenidora, sinó els seus fitxers i subcarpetes.
4. No modificar fitxers directament al servidor sense reflectir el canvi al repositori font.
5. Conservar la referència del commit o tag que s'ha publicat.

Aquest document no considera la publicació completament reproduïble fins que el canal concret de CDmon i el procediment de retorn s'hagin confirmat.

## 7. Verificació posterior

Comprovar com a mínim:

```bash
curl -sSIL https://jbv.cat/
curl -sSIL https://jbv.cat/privadesa.html
```

I revisar al navegador:

- portada i fotografia;
- navegació interna;
- targetes i filtres de projectes;
- enllaços de contacte i GitHub;
- pàgina de privadesa;
- consola JavaScript;
- comportament en mòbil i escriptori.

Finalment, comparar almenys els fitxers principals publicats amb l'artefacte local o verificar-ne els hashes.

## 8. Retorn a una versió anterior

Quan existeixi un tag estable, per exemple `v1.0.0`, el retorn ha de preparar-se des d'una còpia de treball separada d'aquell tag; no s'ha de moure ni reescriure el tag.

Procediment conceptual:

1. obtenir el tag estable en una carpeta de treball separada;
2. executar-ne les comprovacions;
3. generar un artefacte de deploy nou;
4. publicar-lo amb el mateix mecanisme confirmat de CDmon;
5. tornar a verificar producció.

Fins que no es confirmi si CDmon ofereix snapshots o restauració pròpia, no s'ha de donar per garantida una reversió immediata des del proveïdor.

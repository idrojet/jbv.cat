# jbv.cat

Portafoli personal de Jordi Boixader Vilella, publicat a [jbv.cat](https://jbv.cat). És una web estàtica amb una presentació personal, projectes tecnològics, stack habitual i vies de contacte.

## Estat

- Versió estable: `1.0.0`
- Branca estable: `main`
- Tag estable: `v1.0.0`
- Producció: [https://jbv.cat](https://jbv.cat)
- Pla de millores: [`docs/PLA_MILLORES.md`](docs/PLA_MILLORES.md)

## Tecnologies

- HTML5 semàntic
- CSS3 amb custom properties, Grid i Flexbox
- JavaScript vanilla amb mòduls ES
- JetBrains Mono servida localment
- Hostatge estàtic amb Apache a CDmon

El web no utilitza framework, backend, base de dades, cookies ni analítica.

## Estructura

```text
.
├── index.html                 Portada
├── privadesa.html             Informació de privadesa
├── assets/                    Imatges, icones i tipografies
├── css/                       Reset, variables i estils
├── js/                        Lògica i dades dels projectes
├── scripts/prepara-deploy.sh  Preparació reproduïble del deploy
├── tests/                     Comprovacions del procés de deploy
└── docs/                      Pla de millores i desplegament
```

La carpeta germana `/home/jordi/projectes/jbv.cat-deploy` és l'artefacte publicable. No s'ha d'editar manualment: s'ha de regenerar des del repositori.

## Executar en local

```bash
git clone https://github.com/idrojet/jbv.cat.git
cd jbv.cat
python3 -m http.server 8080
```

Obre `http://localhost:8080` al navegador.

Els mòduls ES requereixen servir els fitxers per HTTP; obrir `index.html` directament amb `file://` no és suficient.

## Actualitzar projectes

Les dades públiques dels projectes són a:

```text
js/projects.js
```

Aquest fitxer és la font canònica. La còpia de deploy no ha de contenir canvis exclusius.

## Comprovar el projecte

```bash
npm test
npm run deploy:check
```

- `npm test` prova la preparació del deploy en una carpeta temporal i comprova que detecta divergències.
- `npm run deploy:check` compara la font pública amb `../jbv.cat-deploy` sense modificar-la.

## Preparar el deploy

```bash
npm run deploy:prepare
```

Aquesta ordre sincronitza només `index.html`, `privadesa.html`, `assets/`, `css/` i `js/` amb `../jbv.cat-deploy`, eliminant de l'artefacte qualsevol fitxer que no formi part d'aquesta llista.

La sincronització destructiva amb `rsync --delete` està restringida a aquesta carpeta canònica. Per generar una còpia alternativa només es permet una carpeta nova o buida:

```bash
scripts/prepara-deploy.sh --prepare-new /ruta/destí
```

Prerequisits del procés: Linux o WSL, Bash, `rsync`, Node.js 18.17 o posterior i npm.

El procediment complet i les comprovacions prèvies i posteriors són a [`docs/DESPLEGAMENT.md`](docs/DESPLEGAMENT.md).

## Generació d'icones

Les eines locals per regenerar les icones són `generate-icons.mjs`, `sharp` i `png-to-ico`. El generador i `node_modules/` no formen part del web publicat.

## Documentació

- [`docs/PLA_MILLORES.md`](docs/PLA_MILLORES.md): prioritats, fases i seguiment de millores.
- [`docs/DESPLEGAMENT.md`](docs/DESPLEGAMENT.md): preparació, verificació i publicació.
- [`docs/RELEASE_V1.0.0.md`](docs/RELEASE_V1.0.0.md): abast, verificació i rollback de la versió estable.
- `PLAN.md`: document històric local i ignorat per Git; no és la llista activa de treball.

## Llicència

[MIT](https://opensource.org/licenses/MIT) — Jordi Boixader Vilella

# Pla de millores de jbv.cat

> Document viu per planificar, prioritzar i seguir l'evolució del portafoli.
>
> Última revisió: 14 de juliol de 2026

## 1. Propòsit

Mantenir `jbv.cat` com un portafoli personal clar, ràpid, accessible i fàcil d'actualitzar, preservant l'arquitectura estàtica actual: HTML, CSS i JavaScript sense frameworks.

Aquest document és la referència principal per a les millores pendents. No substitueix el `README.md`, que ha de continuar explicant què és el projecte i com executar-lo.

## 2. Punt de partida verificat

- El web de producció és accessible a `https://jbv.cat` i respon correctament per HTTPS.
- El codi font és a `/home/jordi/projectes/jbv.cat`.
- Els fitxers publicables són a `/home/jordi/projectes/jbv.cat-deploy`.
- La branca local `main` coincideix amb `origin/main` al commit `04edc2f`.
- La producció coincideix amb la carpeta de deploy en els fitxers principals comprovats.
- El web és estàtic i no utilitza backend, base de dades, cookies ni analítica.
- La consola del navegador no mostra errors JavaScript.
- La base visual és coherent i no es considera necessari reescriure el projecte.

### Divergència inicial resolta durant la preparació de la v1.0.0

L'auditoria inicial va detectar que el codi font contenia dos projectes d'exemple que no existien al deploy ni a producció. S'han retirat de `js/projects.js` i ara la font pública coincideix amb `jbv.cat-deploy`.

També s'ha afegit un procés reproduïble i verificat per preparar i comparar l'artefacte de deploy. Encara cal confirmar el canal concret de transferència i retorn a CDmon abans de tancar formalment la versió.

## 3. Objectiu de manteniment

Quan el pla estigui complet:

- el repositori haurà de representar exactament la versió publicable;
- el deploy haurà de ser reproduïble sense edicions manuals;
- el contingut haurà d'explicar millor el valor i l'estat dels projectes;
- el web haurà de tenir una base correcta d'accessibilitat, SEO i configuració HTTP;
- la documentació haurà de reflectir l'estat real del projecte;
- cada publicació haurà de tenir comprovacions i una via de retorn clara.

## 4. Prioritats

### P0 — Integritat de la font i del desplegament

Evitar divergències entre Git, la carpeta de deploy i producció.

### P1 — Contingut i experiència

Fer que el portafoli expliqui millor qui és en Jordi, què construeix i quin resultat tenen els projectes.

### P2 — Qualitat tècnica

Millorar accessibilitat, SEO, rendiment i configuració del servidor.

### P3 — Mantenibilitat

Afegir comprovacions simples i un procés d'actualització documentat.

## 5. Fases de treball

### Fase 0 — Protegir i alinear la base

- [x] Eliminar definitivament els dos projectes d'exemple de les dades publicables.
- [x] Fer que `js/projects.js` sigui la font canònica del contingut publicat.
- [x] Definir què conté exactament `jbv.cat-deploy` i com es genera.
- [x] Evitar edicions manuals exclusives dins de `jbv.cat-deploy`.
- [ ] Confirmar el canal real de publicació i rollback a CDmon; la preparació local ja està documentada a `docs/DESPLEGAMENT.md`.
- [x] Tancar el baseline estable amb el tag Git anotat `v1.0.0` i notes de release pròpies.
- [x] Revisar i actualitzar el `README.md` i retirar afirmacions obsoletes.
- [x] Conservar l'antic `PLAN.md` només com a document històric local i ignorat per Git.

**Criteri de finalització**

- Una comparació entre la font publicable i `jbv.cat-deploy` no mostra diferències inesperades.
- Una persona pot reproduir la carpeta de deploy seguint instruccions documentades.
- El README descriu l'estat real del projecte.

### Fase 1 — Revisar el relat i els projectes

- [ ] Definir l'objectiu principal del web: presentació personal, captació de col·laboracions, aparador tècnic o combinació explícita.
- [ ] Revisar el titular, la bio i la crida a l'acció segons aquest objectiu.
- [ ] Revisar quins projectes han d'aparèixer i en quin ordre.
- [ ] Actualitzar l'estat real de cada projecte.
- [ ] Afegir a cada projecte el problema resolt, el paper d'en Jordi i el resultat o impacte.
- [ ] Valorar captures, demostracions, mètriques o pàgines de detall quan aportin credibilitat.
- [ ] Decidir si cal mantenir els filtres quan totes les targetes pertanyen a una sola categoria.
- [ ] Revisar les tecnologies mostrades perquè reflecteixin l'ús actual.
- [ ] Revisar si el formulari de contacte i el multiidioma continuen sent objectius reals o s'han de descartar.

**Criteri de finalització**

- No hi ha contingut d'exemple ni informació obsoleta.
- Cada projecte comunica què és, què resol, l'estat real i l'aportació d'en Jordi.
- Els filtres i les seccions visibles tenen contingut útil.

### Fase 2 — Accessibilitat i navegació

- [ ] Afegir estils visibles de `:focus-visible` per a enllaços, botons i controls.
- [ ] Comprovar la navegació completa amb teclat.
- [ ] Representar l'estat dels filtres amb `aria-pressed` o una semàntica equivalent.
- [ ] Respectar `prefers-reduced-motion` al typing effect, les revelacions i l'scroll suau.
- [ ] Garantir que el contingut continua disponible si les animacions o `IntersectionObserver` no funcionen.
- [ ] Revisar el contrast del text gris, especialment en mides petites.
- [ ] Decidir i implementar una navegació mòbil; actualment els enllaços desapareixen per sota de 768 px.
- [ ] Revisar etiquetes accessibles, ordre d'encapçalaments i text alternatiu de les imatges.
- [ ] Provar almenys una amplada mòbil, una tauleta i una pantalla d'escriptori.

**Criteri de finalització**

- Tot el web es pot utilitzar només amb teclat.
- Els controls comuniquen visualment i semànticament el seu estat.
- La reducció de moviment del sistema és respectada.
- No hi ha contingut ocult permanentment per una fallada de JavaScript o d'animació.
- La navegació continua disponible en mòbil.

### Fase 3 — SEO i compartició

- [ ] Afegir una URL canònica a la portada i a la pàgina de privadesa.
- [ ] Crear una imatge social i afegir `og:image` amb dimensions i text alternatiu.
- [ ] Afegir les metadades necessàries per a Twitter/X Cards.
- [ ] Crear `robots.txt`.
- [ ] Crear `sitemap.xml` amb les pàgines públiques reals.
- [ ] Afegir dades estructurades JSON-LD de tipus `Person` i, si escau, `WebSite`.
- [ ] Revisar títols, descripcions i URLs de totes les pàgines.
- [ ] Validar les previsualitzacions socials i les dades estructurades.

**Criteri de finalització**

- `robots.txt` i `sitemap.xml` responen amb HTTP 200.
- Cada pàgina té títol, descripció i URL canònica correctes.
- Els enllaços compartits generen una previsualització amb títol, descripció i imatge.
- Les dades estructurades passen una validació sense errors crítics.

### Fase 4 — Rendiment i recursos

- [ ] Convertir o complementar la fotografia principal amb WebP o AVIF.
- [ ] Definir `width` i `height` explícits a la imatge per reduir canvis de layout.
- [ ] Revisar si cal precarregar només el recurs crític necessari.
- [ ] Comprovar la mida total transferida i les fonts realment utilitzades.
- [ ] Definir una política de caché adequada per a HTML i recursos estàtics.
- [ ] Mesurar el web abans i després dels canvis amb una eina reproduïble.

**Criteri de finalització**

- La fotografia manté una qualitat visual adequada amb menys pes.
- No hi ha canvis de layout evitables causats per imatges.
- HTML i recursos estàtics tenen polítiques de caché deliberades.
- Les mètriques principals no empitjoren respecte del punt de partida.

### Fase 5 — Domini i configuració HTTP

- [ ] Corregir el certificat de `www.jbv.cat` o retirar aquesta variant si no s'ha d'utilitzar.
- [ ] Fer que `http://www.jbv.cat` no redirigeixi cap a una URL amb certificat invàlid.
- [ ] Definir una única URL canònica: `https://jbv.cat/`.
- [ ] Valorar i configurar HSTS quan totes les variants HTTPS siguin correctes.
- [ ] Afegir `X-Content-Type-Options`.
- [ ] Afegir una `Referrer-Policy` adequada.
- [ ] Afegir una `Permissions-Policy` mínima.
- [ ] Definir i provar una Content Security Policy compatible amb el web actual.
- [ ] Reduir la informació de versió exposada pel servidor, si CDmon ho permet.
- [ ] Comprovar que les pàgines inexistents retornen un 404 correcte.

**Criteri de finalització**

- Cap variant pública del domini produeix errors de certificat.
- Totes les variants redirigeixen de manera coherent a la URL canònica.
- Les capçaleres acordades apareixen a les respostes de producció.
- La Content Security Policy no trenca estils, scripts, fonts ni imatges.

### Fase 6 — Comprovacions i procés de publicació

- [ ] Afegir una comprovació de sintaxi o qualitat per a HTML, CSS i JavaScript.
- [ ] Comprovar automàticament les referències a fitxers locals.
- [ ] Comprovar els enllaços externs sense convertir errors temporals en desplegaments fallits injustificats.
- [x] Definir una ordre reproduïble per generar o sincronitzar `jbv.cat-deploy`.
- [x] Evitar que documentació, dependències i eines locals entrin al deploy.
- [ ] Confirmar el mecanisme real de còpia de seguretat, publicació i retorn a CDmon; la seqüència local i la verificació ja estan documentades.
- [ ] Decidir si aquestes comprovacions s'executen només en local o també a GitHub Actions.
- [ ] Incloure la llicència OFL de JetBrains Mono o la referència de llicència corresponent.

**Criteri de finalització**

- Una única seqüència documentada valida i prepara el deploy.
- El procés falla abans de publicar si falta un recurs local o hi ha un error crític.
- Es pot identificar què es va publicar i recuperar la versió anterior.

### Fase 7 — Verificació final de producció

- [ ] Revisar portada, projectes, stack, contacte i privadesa en producció.
- [ ] Provar els filtres i tots els enllaços públics.
- [ ] Comprovar consola JavaScript i peticions fallides.
- [ ] Provar teclat, mòbil i reducció de moviment.
- [ ] Verificar HTTP, HTTPS, domini canònic, `www`, 404 i capçaleres.
- [ ] Comparar els fitxers publicats amb el deploy preparat.
- [ ] Actualitzar aquest pla, el README i la data de revisió.

**Criteri de finalització**

- Producció coincideix amb l'artefacte de deploy aprovat.
- No hi ha errors crítics visuals, funcionals, d'accessibilitat ni de consola.
- La documentació explica fidelment l'estat publicat.

## 6. Decisions obertes

Aquestes decisions s'han de prendre abans d'implementar les parts que en depenen:

1. Quin és l'objectiu principal del portafoli?
2. Quins projectes han de ser visibles i quins poden explicar-se públicament?
3. Els projectes necessiten pàgines pròpies o n'hi ha prou amb targetes més completes?
4. Cal conservar la categoria «Pendent» en un web públic?
5. Cal multiidioma ara, més endavant o no cal?
6. Cal formulari de contacte o és preferible mantenir només correu i GitHub?
7. Quin és exactament el procediment de publicació a CDmon i quina capacitat de rollback ofereix?
8. `www.jbv.cat` s'ha de mantenir com a àlies o eliminar?
9. Es vol mantenir el crèdit «Fet amb Claude Code» al peu de pàgina?

## 7. Regla d'actualització de la documentació

Quan es completi una millora:

1. marcar la casella corresponent en aquest document;
2. actualitzar la data d'«Última revisió»;
3. actualitzar el `README.md` si canvien l'estructura, l'execució local, el deploy o les característiques actives;
4. actualitzar els textos legals si s'afegeixen serveis externs, formularis, cookies o analítica;
5. registrar una decisió al mateix canvi quan afecti arquitectura, contingut públic o desplegament;
6. no marcar una tasca com a completada fins que s'hagi verificat en l'entorn corresponent.

L'antic `PLAN.md` no s'ha d'utilitzar com una segona llista activa de millores. Es conserva com a document històric local i ignorat per Git; aquest `PLA_MILLORES.md` és l'única llista activa.

## 8. Definició global de “fet”

Una fase o tasca només es considera completada quan:

- el canvi està implementat al codi font;
- les comprovacions pertinents passen;
- s'ha revisat visualment quan correspon;
- la carpeta de deploy s'ha generat de manera reproduïble;
- la producció s'ha verificat després de publicar;
- la documentació afectada està actualitzada;
- existeix una manera clara de revertir el canvi si causa problemes.

## 9. Ordre recomanat d'execució

1. Fase 0 — Protegir i alinear la base.
2. Fase 1 — Revisar el relat i els projectes.
3. Fase 2 — Accessibilitat i navegació.
4. Fase 3 — SEO i compartició.
5. Fase 4 — Rendiment i recursos.
6. Fase 5 — Domini i configuració HTTP.
7. Fase 6 — Comprovacions i procés de publicació.
8. Fase 7 — Verificació final de producció.

Les fases es poden dividir en canvis petits. No cal esperar a completar tot el pla per publicar millores segures i independents.

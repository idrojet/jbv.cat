# jbv.cat

Portafoli personal com a desenvolupador i creador. Web estàtica amb llistat de projectes tecnològics filtrable per estat.

## Tecnologies

- HTML5, CSS3, JavaScript (ES modules, sense frameworks)
- JetBrains Mono (self-hosted, llicència OFL)

## Executar en local

```bash
git clone https://github.com/idrojet/jbv.cat.git
cd jbv.cat
python3 -m http.server 8080
```

Obre `http://localhost:8080` al navegador.

> Els ES modules requereixen servir els fitxers via HTTP, no des de `file://`.

> El web no fa crides a serveis externs: totes les tipografies es serveixen localment des de `assets/fonts/`.

## Ús com a plantilla

Aquest repositori inclou dos projectes d'exemple (un amb estat "Fet" i un amb estat "Pendent") a `js/projects.js`. Són intencionals: serveixen per mostrar el format de dades i com es renderitzen les cards segons l'estat.

Si vols fer servir aquest portafoli com a plantilla per al teu:

- Edita `js/projects.js` amb els teus projectes reals
- Substitueix `assets/img/jbv.cat-jordi.png` per la teva foto (PNG amb fons transparent recomanat)
- Canvia noms, bio, email i enllaços socials a `index.html`
- Ajusta la paleta de colors a `css/variables.css` si vols un altre estil

## Llicència

[MIT](https://opensource.org/licenses/MIT) — Jordi Boixader Vilella

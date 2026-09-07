// LTeX: enabled=false

#import "@preview/touying:0.7.4": *
#import "@preview/grayness:0.7.0": image-transparency
#import "@preview/metalogo:1.2.0": LaTeX
#import "@preview/gentle-clues:1.3.1": *

#import themes.simple: *


/* CONFIG */

#set text(lang: "es", font: "Trebuchet MS")

#let primary-color = rgb("#1c3144")
#let title = [Trivia Jornadas de Bienvenida]
#let org = [GUL UC3M]

// pass the "HANDOUT" variable w/ --input to enable presentation mode
#let handout-mode = (
  sys.inputs.at("HANDOUT", default: none) != none
)

#show: simple-theme.with(
  aspect-ratio: "4-3",
  header: none,
  footer: [#org],
  primary: primary-color,
  config-common(
    handout: handout-mode,
  ),
)

// custom title slide

#let my-title-slide(body, config: (:)) = title-slide(
  place(
    top + center,
    image-transparency(
      read("img/gul-logo.svg", encoding: none),
      alpha: 30%,
      format: "svg",
    ),
  )
    + body,
  config: config,
)


/* ESTILO */

// emoji fix
#set text(top-edge: "bounds")

#set list(indent: 1em, spacing: 1em)
#set enum(indent: 1em, spacing: 1em)

// fix LaTeX symbol font
#let LaTeX = {
  set text(font: "New Computer Modern")
  LaTeX
}

// use the `<bold>` label to make an element of an enumerated list bold
// see https://forum.typst.app/t/how-to-make-a-single-numbered-list-item-marker-bold/9839/2
#show enum: it => {
  if it.at("label", default: none) == <processed> {
    return it
  }

  let args = it.fields()
  let children = args.remove("children")
  let boldness = children.map(c => c.body.at("label", default: none) == <bold>)

  show <bold>: strong.with(delta: 800)
  [#enum(
    ..args,
    numbering: n => {
      let numbering = numbering("a)", n)
      if boldness.at(n - 1) {
        strong(delta: 800, numbering)
      } else { numbering }
    },
    ..children,
  )<processed>]
}



/* PORTADA */

#title-slide[
  #image("img/portada.png", width: 122%)
  #set text(font: "Arial")
  (buscamos diseñador gráfico)
]


/* PREGUNTAS */

#let i = state("pregunta", 1)
#let pregunta(body, num-subslides: 2) = {
  [== *Pregunta #context { i.get() }*]
  body

  // update counter (only on last subslide)
  touying-fn-wrapper(
    (self: none) => if self.subslide == num-subslides { i.update(i => i + 1) },
  )
}

/// Crea un "apunte" a la pregunta que se desvela con la respuesta
///
/// - body (content): Contenido del apunte
///
/// -> function
#let apunte(body) = {
  set align(center)
  uncover("2-", body)
}

#let correcta(answer) = {
  alternatives([+ #answer], [+ #answer<bold>])
}


#pregunta[
  - ¿Cómo se llama el creador de Linux?
    + 🇺🇸 John Linux
    #correcta[🇫🇮 Linus Torvalds]
    + 🇫🇷 Eugène de Lineaux
    + 🇨🇺 Juan

  #apunte({
    v(.5em)
    info[Linux fue lanzado en 1991, cuando Torvalds estaba todavía en la
      universidad. ¡Como tú!]
  })
]


#pregunta[
  - ¿En qué año se fundó el GUL-UC3M?
    + 2012
    #correcta[1995]
    + 69 A.D.
    + 2026

  #apunte(image("img/gul-horizontal.svg", width: 57%))
]


#pregunta[
  - ¿Cómo es el diagrama de Venn entre usuarios de Linux y _femboys_?
    + Círculo perfecto
    #correcta[Círculo semiperfecto]
    + Sólo se tocan la puntita
    + No hay relación

  #apunte(image("img/unixsocks.png", width: 44%))
]

#pregunta[
  - ¿Puedes jugar a todos tus juegos favoritos en Linux?
    + ¡Si!
    #correcta[Si\*]
    + No
    + Microslop nunca lo permitirá

  #apunte(link("https://www.protondb.com/", image(
    "img/protondb.png",
    width: 47%,
  ))) // caca
]

#pregunta[
  - ¿Qué animal es la mascota de Linux?
    + #emoji.rat Rata
    + #emoji.dog Perro
    + #emoji.cat Gato
    #correcta[#emoji.penguin Pingüino]

  #apunte(quotation(
    title: "Linus Torvalds dijo...",
    header-inset: .4em,
    content-inset: .8em,
  )[_Some people have told me they don't think a fat penguin really embodies the
  grace of Linux, which just tells me they have never seen an angry penguin
  charging at them in excess of 100 mph._])
]

#pregunta[
  - ¿Cómo se llama la mascota de Linux?
    #correcta[Tux]
    + Keith
    + Ling
    + Juan

  #apunte(notify(title: "Dato curioso", grid(
    columns: (1.2fr, 1fr),
    [_Keith_ es la mascota no oficial de C++],
    image("img/keith.png", height: 3.5cm),
  )))

]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *escritorio*?
    #correcta[~5%]
    + ~50%
    + ~90%
    + ~100%

  #apunte(info[¡En móviles, Android (basado en Linux) tiene \~70%!])
]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *servidor*?
    + ~5%
    + ~50%
    #correcta[~90%]
    + ~100%
]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *supercomputadores*?
    + ~5%
    + ~50%
    + ~90%
    #correcta[~100%]
]

#pregunta[
  - ¿Con qué está hecha esta presentación?
    + Google Slides
    + Microsoft PowerPoint
    + #LaTeX
    #correcta[Typst]

  // generado con https://thegruber.github.io/linkpeek/
  #apunte(link("https://github.com/guluc3m/trivia", image(
    "img/repo.png",
    width: 60%,
  )))
]

#pregunta[
  - ¿Cuál de estos sistemas NO puede correr linux?
    + Nintento Wii
    + Apple Macbook Pro
    + El GPS de un coche
    + Una tostadora
    #correcta[Todo corre Linux. Con paciencia y con saliva...]

  #apunte({
    set align(center)
    grid(
      columns: (5cm, 5cm),
      column-gutter: 3cm,
      link("https://wii-linux.org/", image("img/wii-linux.png")),
      link("https://asahilinux.org/", image("img/asahi.png")),
    )
  })
]


#pregunta[
  - ¿Cual es mi color favorito?
    + #emoji.circle.red Rojo
    + #emoji.circle.blue Azul
    + #emoji.circle.green #emoji.circle.blue Cyan
    + #emoji.circle.white Ultravioleta

  #pause
  #v(.7em)
  #abstract(title: "Nota")[Esto depende de a quién le preguntes. Para el autor,
    es el Cyan :3.]
]


/* RONDA RÁPIDA */


#let si = uncover("2-")[#emoji.checkmark.box]
#let no = uncover("2-")[#emoji.crossmark]
#let maomeno = uncover("2-")[#emoji.hand.pinch]

#let ronda-rapida(title, apps) = {
  heading([*Ronda rápida: #title*], depth: 2)
  let is-fs(value) = {
    if value == none {
      emoji.hand.pinch
    } else if value {
      emoji.checkmark.box
    } else {
      emoji.crossmark
    }
  }

  for (name, value) in apps {
    [- #name #pause #is-fs(value) #pause]
  }
}

#ronda-rapida([¿Software Libre o no?], (
  ([#emoji.window Windows], false),
  ([#emoji.penguin Linux], true),
  ([#emoji.apple MacOS], false),
  // ([#emoji.briefcase Microsoft Office], false),
  ([#emoji.palette Blender], true),
  ([#emoji.camera.video OBS], true),
  ([#emoji.laptop Visual Studio Code], none),
  ([#emoji.notepad Obsidian], false),
  ([#emoji.mortarboard OpenUC3M], false),
  ([#emoji.globe Google Chrome], none),
  ([#emoji.fox Firefox], true),
))

#my-title-slide[
  = ¡Gracias por participar!

  #v(1em)

  Grupo de Usuarios de Linux de la UC3M

  \@guluc3m
]

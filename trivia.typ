// LTEX: language=es-ES
// LTeX: enabled=false

#import "@preview/touying:0.7.4": *
#import "@preview/grayness:0.7.0": image-transparency
#import "@preview/metalogo:1.2.0": LaTeX
#import "@preview/gentle-clues:1.3.1": *

#import themes.simple: *


/* CONFIG */

#set text(lang: "es")

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
  footer: [#org --- #title],
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


// emoji fix
#set text(top-edge: "bounds")

#set list(indent: 1em, spacing: 1em)
#set enum(indent: 1em, spacing: 1em)



#my-title-slide[
  #heading(strong(title), outlined: false)
  #v(2em)

  #v(1em)

  #link("https://gul.uc3m.es", org)

  10 de Septiembre 2026
]


/* PREGUNTAS */

#let i = state("pregunta", 1)
#let pregunta(body, num-subslides: 2) = {
  [== *Pregunta #context { i.get() }*]
  parbreak()
  body

  // update counter (only on last subslide)
  touying-fn-wrapper(
    (self: none) => if self.subslide == num-subslides { i.update(i => i + 1) },
  )
}

#let si = uncover("2-")[#emoji.checkmark.box]
#let no = uncover("2-")[#emoji.crossmark]
#let ma-o-menon = uncover("2-")[#emoji.hand.pinch]
#let apunte = uncover.with("2-")


// LTeX: enabled=true

#pregunta[
  - ¿Cómo se llama el creador de Linux?
    + 🇺🇸 John Linux
    + 🇫🇮 Linus Torvalds#si
    + 🇫🇷 Eugène de Lineaux
    + 🇨🇺 Juan

    #apunte(info[Linux fue lanzado en 1991, cuando Torvalds estaba todavía en la
      universidad. ¡Como tú!])
]


#pregunta[
  - ¿En qué año se fundó el GUL-UC3M?
    + 2012
    + 1995 #si
    + 69 A.D.
    + 2026

    #apunte(figure(image("img/gul-horizontal.svg", width: 60%)))
]


#pregunta[
  - ¿Cómo es el diagrama de Venn entre usuarios de Linux y _femboys_?
    + Círculo perfecto
    + Círculo semiperfecto #si
    + Sólo se tocan la puntita
    + No hay relación

    #apunte(figure(image("img/unixsocks.png", width: 49%)))
]

#pregunta[
  - ¿Puedes jugar a todos tus juegos favoritos en Linux?
    + ¡Si!
    + Si\* #si
    + No
    + Microslop nunca lo permitirá

    #apunte(figure(image("img/protondb.png", width: 53%)))
]

#pregunta[
  - ¿Qué animal es la mascota de Linux?
    + #emoji.rat Rata
    + #emoji.dog Perro
    + #emoji.cat Gato
    + #emoji.penguin Pingüino #si

    #apunte(quotation(title: "Linus Torvalds dijo...")[_Some people have told me they don't think a fat penguin really embodies the grace of Linux, which just tells me they have never seen an angry penguin charging at them in excess of 100 mph._])
]

#pregunta[
  - ¿Cómo se llama la mascota de Linux?
    + Tux #si
    + Keith
    + Ling
    + Juan

    #apunte(notify(title: "Dato curioso", grid(
      columns: (1fr, 1fr),
      [_Keith_ es la mascota no oficial de C++],
      figure(image("img/keith.png", height: 3.5cm)),
    )))

]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *escritorio*?
    + ~5% #si
    + ~50%
    + ~90%
    + ~100%

    #apunte(info[¡En móviles, Android (basado en Linux) tiene \~70%!])
]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *servidor*?
    + ~5%
    + ~50%
    + ~90% #si
    + ~100%
]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *supercomputadores*?
    + ~5%
    + ~50%
    + ~90%
    + ~100% #si
]

#pregunta[
  - ¿Con qué está hecha esta presentación?
    + Google Slides
    + Microsoft PowerPoint
    + #LaTeX
    + Typst #si

    #apunte[
      #figure(image("img/repo.png", width: 60%))
    ]
]


#pregunta[
  - ¿Cual es mi color favorito?
    + #emoji.circle.red Rojo
    + #emoji.circle.blue Azul
    + #emoji.circle.green #emoji.circle.blue Cyan
    + #emoji.circle.white Ultravioleta

    #pause

    #abstract(title: "Nota")[El autor de esta presentación puede no ser el mismo que
      te esté haciendo las preguntas, por lo que no sabe la respuesta de
      antemano.]
]


// LTeX: enabled=false
#let ronda-rapida(title, apps) = {
  [== *Ronda rápida: #title*]
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

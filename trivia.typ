// LTEX: language=es-ES
// LTeX: enabled=false

#import "@preview/touying:0.7.4": *
#import "@preview/grayness:0.7.0": image-transparency
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
    handout: handout-mode
  ),
)

// custom title slide

#let my-title-slide(body, config: (:)) = title-slide(
  place(
    top + center,
    image-transparency(
      read("gul-logo.svg", encoding: none),
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


// LTeX: enabled=true

#pregunta[
  - ¿Cómo se llama el creador de Linux?
    1. John Linux
    2. Linus Torvalds #si
    3. Eugène de Lineaux
    4. Juan
]


#pregunta[
  - ¿En qué año se fundó el GUL-UC3M?
    1. 2012
    2. 1995 #si
    3. 69 A.D.
    4. 2026
]


#pregunta[
  - ¿Cómo es el diagrama de Venn entre usuarios de Linux (varones) y Femboys?
    1. Círculo perfecto
    2. Círculo semiperfecto #si
    3. Sólo se tocan la puntita
    4. No hay relación
]

#pregunta[
  - ¿Puedes jugar a todos tus juegos favoritos en Linux?
    1. ¡Si!
    2. Si\* #si
    3. No
    4. Microslop nunca lo permitirá
]

#pregunta[
  - ¿Qué animal es la mascota de Linux?
    1. Rata #emoji.rat
    2. Perro #emoji.dog
    3. Gato #emoji.cat
    4. Pingüino #emoji.penguin #si
]

#pregunta[
  - ¿Cómo se llama la mascota de Linux?
    1. Tux #si
    2. Keith
    3. Linus
    4. Juan
]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *escritorio*?
    1. ~5% #si
    2. ~50%
    3. ~90%
    4. ~100%
]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *servidor*?
    1. ~5%
    2. ~50%
    3. ~90% #si
    4. ~100%
]

#pregunta[
  - ¿Qué porcentaje de cuota de mercado tiene Linux en *supercomputadores*?
    1. ~5%
    2. ~50%
    3. ~90%
    4. ~100% #si
]

#pregunta[
  - ¿Cual es mi color favorito?
    1. Rojo
    2. Azul
    3. Cyan #si
    4. Ultravioleta
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
  ([Linux], true),
  ([Windows], false),
  ([MacOS], false),
  ([Microsoft Office], false),
  ([OBS], true),
  ([Visual Studio Code], none),
  ([Obsidian], false),
  ([Google Chrome], none),
  ([Firefox], true),
))

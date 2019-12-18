# Development

I want to provide API that:

```elm
import Capsule.Element exposing (box, content)
import Capsule.Layout as Layout
import Capsule.Modifier as Modifier exposing (toClassList)
import Capsule.Modifier.Color exposing (color, isPrimary)
import Capsule.Modifier.Helper exposing (isRadiusless)
import Html exposing (Attribute, Html)


view : Html msg
view =
    Layout.section
        []
        [ box
            ( toClassList
                [ backGroundColor isPrimary
                , isRadiusless 
                ]
            )
            [ content [] [ text "Lorem Ipsum" ]
            ]
        ]

{-
  <section class="section">
    <div class="box has-background-primary is-radiusless">
      <div class="content">
        Lorem Ipsum
      </div>
    </div>
  </section>
-}
```

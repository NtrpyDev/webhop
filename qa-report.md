# CS2 Map Lab QA Sweep

Server: 127.0.0.1:8471, page `/viewer/play.html`. 14 maps x 2 render modes (wireframe / textured), Playwright + swiftshader-webgl. Screenshots in `/home/glorg/Pictures/qa/`.

| map | mode | loads | moves | tris | verdict |
|---|---|---|---|---|---|
| ar_pool_day | wireframe | yes | no | 258,164 | suspicious: no movement on W hold at spawn (also fails in textured mode) |
| ar_pool_day | textured | yes | no | 258,164 | suspicious: no movement on W hold at spawn (also fails in wireframe mode); textures/geometry otherwise valid |
| cs_italy | wireframe | yes | yes | 1,319,896 | ok |
| cs_italy | textured | yes | yes | 1,319,896 | ok |
| cs_office | wireframe | yes | yes | 109,010 | ok |
| cs_office | textured | yes | yes | 109,010 | ok |
| cs_shelter | wireframe | yes | yes | 2,855,489 | ok |
| cs_shelter | textured | yes | yes | 2,855,489 | ok |
| de_ancient | wireframe | yes | yes | 965,603 | ok |
| de_ancient | textured | yes | yes | 965,603 | ok |
| de_anubis | wireframe | yes | yes | 762,838 | ok |
| de_anubis | textured | yes | yes | 762,838 | suspicious: large solid white untextured triangle floating over the street, missing texture/UV |
| de_cache | wireframe | yes | yes | 1,632,657 | ok |
| de_cache | textured | yes | yes | 1,632,657 | ok |
| de_dust2 | wireframe | yes | no | 433,063 | suspicious: no movement on W hold at spawn (textured mode moves fine, low fps ~7 during wireframe likely starved the physics tick) |
| de_dust2 | textured | yes | yes | 433,063 | ok |
| de_inferno | wireframe | yes | yes | 2,707,934 | ok |
| de_inferno | textured | yes | yes | 2,707,934 | ok |
| de_mirage | wireframe | yes | yes | 132,105 | ok |
| de_mirage | textured | yes | yes | 132,105 | ok |
| de_nuke | wireframe | yes | no | 189,062 | suspicious: no movement on W hold at spawn (textured mode moves fine, low fps ~5 during wireframe likely starved the physics tick) |
| de_nuke | textured | yes | yes | 189,062 | suspicious: solid white untextured triangle patch on the ground near spawn, missing texture/UV |
| de_overpass | wireframe | yes | yes | 1,388,105 | ok |
| de_overpass | textured | yes | yes | 1,388,105 | ok |
| de_train | wireframe | yes | yes | 1,569,073 | ok |
| de_train | textured | yes | yes | 1,569,073 | ok |
| de_vertigo | wireframe | yes | yes | 207,367 | ok |
| de_vertigo | textured | yes | yes | 207,367 | ok |

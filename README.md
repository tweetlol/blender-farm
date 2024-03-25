# blender-farm

built using [LogicReinc's BlendFarm](https://github.com/LogicReinc/LogicReinc.BlendFarm/tree/main)

## rendering client setup

- download and run the [binary app](https://github.com/LogicReinc/LogicReinc.BlendFarm/releases) (.exe, or equiv. for your version of OS)
- select your .blend file and blender version, load the project *(check: blender settings: external data nescessity?)*
- add available render nodes under `New Node` (remember to use port `:15000` every time when adding a node):

![add render nodes here](https://github.com/tweetlol/blender-farm/blob/main/dev/images/add-render-node.jpg?raw=true)

- turn the rendering nodes on/off:

![render nodes off/on](https://github.com/tweetlol/blender-farm/blob/main/dev/images/render-nodes-on-off.jpg?raw=true)

- sync nodes (automatic)
- **render**
- explore more features (live preview)
- sorry about the UI

___
___

- remote rendering server machine setup in [/dev](https://github.com/tweetlol/blender-farm/tree/main/dev)

# isaac-helper
A modular, expanded TBoI: Repentance helper library where you only need to download the submodules you need.

Each submodule has full documentation. 

# About luamod support
I decided to put this section at the top because it is important to know if you want to use the module.

`luamod` will work with this library, but you must call `require` whenever you need the isaac-helper module. This is because the module needs to store all of the 

# How to install, documentation, examples, and general information
[You can find out how to install, how to use, get documentation, learn the purposes of all submodules, and more by checking out the gitbook website!](https://maya-bee.gitbook.io/api-docs/)

# QnA
This is copied from the website and may be slightly outdated.

### **Do I need to download all of the submodules?**
No. Only the ones you want and their dependencies.

### **Can I use this in my mod without credit?**
Yes. I do not need credit, but letting me know if I helped you makes me happy (I can even advertise your mod on this repository if you want, but it must be SFW).

### **Do I need the main module to use the submodules?**
Technically, you don't, but it's a bit more complicated to set up.

1.) Download the submodule and its dependencies and put them in a folder within the folder in your mod that corrosponds to the name of your mod's directory. For example:
```
mod-name/
├── main.lua (the main lua file for your mod)
├── metadata.xml (steam workshop file)
└── mod-name/ (the same name as your mod folder)
    ├── submodule.lua (the submodule) 
    └── otherSubmodule.lua (the other submodule it depends on, if it has one)
```

2.) Include and initialize the submodule with your mod reference.
```lua
local MyMod = RegisterMod("MyMod", 1) -- replace MyMod with the name of your mod
local ExtraMath = include("Path.To.Submodule") -- replace MyMod with the name of the mod's folder

ExtraMath(MyMod, "Path.To.Submodule") -- replace the path with the path to the folder the submodule is in. Some modules do not require these arguments, but it is best if you include them anyway.

-- Example use of the ExtraMath submodule
local x = 25
local y = ExtraMath:Clamp(x, 0, 10)

print(y) -- 10
```


### **What is the advantage of this module?**
You only need to download the functionality you need. This reduces clutter, file size, load time, and allows people looking through your mod's code to better understand what makes it tick. At least for me, it would make my mod feel more organized.

It's important to note that file size and load time is not necessary to optimize, but I personally like to keep my mod's file size as small as possible.

### **Although that's nice, that doesn't seem necessary**
It's not. I personally don't like big frameworks with hundreds of functions. I only want what I need. If you're like me and just want to keep it compact and organized, this is for you. 

### **Who is this for?**
Mainly myself, but I made it public for people who want to use it. I'm not sure if anyone else will use it, but I hope it helps someone.

# Contact
Need extra help? [Contact me on discord by joining my server](https://discord.gg/bNhNkGa6QX) and sending me a DM. 

# Credits
Thanks to the following people for their contributions to this project:
- Zamiel for debating with me for ~~almost two hours~~ (UPDATE: two and a half hours now) about how this module is bad DX, doesn't scale well, and is a bad idea. I'm still not convinced, but I'm not going to argue with him anymore.
- ((((therealgoncholito))))#8378 for saying my idea is "actually pretty good."
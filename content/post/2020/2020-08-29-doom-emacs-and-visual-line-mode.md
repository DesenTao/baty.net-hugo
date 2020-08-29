---
title: "Respecting visual lines in Doom Emacs"
date: 2020-08-29T10:54:17.637Z
draft: true
tags: ["Emacs"]
---

Emacs evil mode wasn't properly handling j & k motion commands when traversing
wrapped (visual) lines. I use `visual-line-mode` with modes such as Markdown 
and prefer that movements operate via visual lines and not logical ones. Of course there's a setting for this and of course I needed to look it up; `evil-respect-visual-line-mode`.

I added the following to my config.el...

`(setq evil-respect-visual-line-mode t)`

It didn't work. I learned that the setting had to be configured _before_ loading Evil. But how to do that in [Doom Emacs](https://github.com/hlissner/doom-emacs)? I first tried moving it into Emacs 27's new `early-init.el`, which worked, but since early-init.el is part of Doom and not part of my personal config, I didn't love that solution.

The answer was to use Doom's `use-package-hook!` in `init.el`, like so...

```lisp
(use-package-hook! evil
  :pre-init
  (setq evil-respect-visual-line-mode t) ;; sane j and k behavior
  t)
```

Much better.

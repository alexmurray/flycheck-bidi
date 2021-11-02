# Flycheck Bidi (aka Trojan Source) Checker

[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
<!-- [![MELPA](http://melpa.org/packages/flycheck-flawfinder-badge.svg)](http://melpa.org/#/flycheck-flawfinder) -->
<!-- [![Build Status](https://travis-ci.org/alexmurray/flycheck-flawfinder.svg?branch=master)](https://travis-ci.org/alexmurray/flycheck-flawfinder) -->

Warn on presence of bidirectional Unicode control characters within source code to avoid possible "Trojan Source" code attacks. NOTE: This was created more as a demonstration rather than due to a perceived need as detailed in the Why? section below.

## Why

Emacs already has great Unicode bidirectional text handling, and in fact does a great job of correctly syntax highlighting code with bidi control characters - so in the example at [trojan-source/C/commenting-out.c](https://github.com/nickboucher/trojan-source/blob/be30965b7091c14bda65c1d82f582c8733779827/C/commenting-out.c) the trailing `if (isAdmin)` is correctly shown as part of the comment.

![](https://github.com/alexmurray/flycheck-bidi/raw/main/commenting-out.png)


However to be extra careful, this extension will point them out so you don't miss them:

![](https://github.com/alexmurray/flycheck-bidi/raw/main/commenting-out-flycheck-bidi.png)

## Installation

### MELPA (coming soon)

The preferred way to install `flycheck-bidi` is via
[MELPA](http://melpa.org) - then you can just <kbd>M-x package-install RET
flycheck-bidi RET</kbd>

To enable then simply add the following to your init file:

```emacs-lisp
(with-eval-after-load 'flycheck
  (require 'flycheck-bidi)
  (flycheck-bidi-setup)
  ;; chain after cppcheck since this is the last checker in the upstream
  ;; configuration
  (flycheck-add-next-checker 'c/c++-cppcheck '(warning . bidi)))
```

If you do not use `cppcheck` then chain after whichever checker you do use
(ie. clang / gcc / irony etc)

```emacs-lisp
(flycheck-add-next-checker 'c/c++-clang '(warning . bidi))
```

### Manual

If you would like to install the package manually, download or clone it and
place within Emacs' `load-path`, then you can require it in your init file like
this:

```emacs-lisp
(require 'flycheck-bidi)
(flycheck-bidi-setup)
```

NOTE: This will also require the manual installation of `flycheck` if you have not done so already.

## License

Copyright © 2021 Alex Murray

Distributed under GNU GPL, version 3.

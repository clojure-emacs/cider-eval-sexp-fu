# cider-eval-sexp-fu

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc/generate-toc again -->
**Table of Contents**

- [cider-eval-sexp-fu](#cider-eval-sexp-fu)
    - [Install](#install)
    - [Usage](#usage)
    - [Customization](#customization)

<!-- markdown-toc end -->

eval-sexp-fu.el extensions for [CIDER][].
This package briefly highlights evaluated sexps in a clojure buffer
connected to an nREPL via [CIDER][].

## Install

The package is available in [MELPA][].

If you have MELPA in your `package-archives` variable, just use

    M-x package-install RET vi-tilde-fringe-mode RET

If you don't, open `vi-tilde-fringe.el` in Emacs and call
`package-install-from-buffer`.

## Usage

Just require it:

```elisp
(require 'cider-eval-sexp-fu)
```

## Customization

Customization is done via [eval-sexp-fu][].

[MELPA]: http://melpa.org/
[eval-sexp-fu]: https://github.com/hchbaw/eval-sexp-fu.el
[CIDER]: https://github.com/clojure-emacs/cider

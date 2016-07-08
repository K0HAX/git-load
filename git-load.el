;;; git-load.el --- Load git repositories as packages.
;; Copyright 2016 Michael Englehorn
;;
;; Author: Michael Englehorn <michael@englehorn.com>
;; Maintainer: Michael Englehorn <michael@englehorn.com>
;; Keywords: git git-load
;; URL: https://github.com/K0HAX/git-load
;; Created: 24 June 2016
;; Version: 0.1.1
;; Package-Requires: ((git "0.0.0"))

;;; Commentary:
;;
;; An API to load packages from arbitrary git repositories
;;

;;; Code:

(require 'git)

(defvar git-load-default-directory "~/.emacs.d/git/")

(defun git-load (git-load-repository git-load-package-name &optional directory)
  "
  This function takes a git repository location, package name and optionally a directory, and loads it into Emacs as a package.
  Think of it as making all of github into one huge MELPA repo.
  "
  (unless directory (setq directory git-load-default-directory))
  (unless (git-repo? (concat directory git-load-package-name))
    (let ((git-repo directory))
      (git-clone git-load-repository)))
  (add-to-list 'load-path (concat directory git-load-package-name))
  (byte-recompile-directory (expand-file-name (concat directory git-load-package-name)) 0)
  (load git-load-package-name))

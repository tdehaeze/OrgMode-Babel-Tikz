# Tikz Pictures Maker

<!-- vim-markdown-toc GFM -->

* [Using the Makefile](#using-the-makefile)
    * [Create a Tikz File](#create-a-tikz-file)
    * [Tikz](#tikz)

<!-- vim-markdown-toc -->


## Using the Makefile

| command      | filename     | commentary                                                                     |
| ------------ | ------------ | ------------------------------------------------------------------------------ |
| `make`       |              | Build all `.tex` files into the `ressources/tikz/` folder into `.pdf` files    |
| `make`       | `f=filename` | Build `ressources/tikz/filename.tex` into `ressources/tikz/filename.pdf`       |
| `make watch` | `f=filename` | Continuously compile a tikz file into a pdf                                    |
| `make open`  | `f=filename` | Open the pdf file corresponding to the Tikz figure                             |


### Create a Tikz File

| command      | filename     | commentary                                                                               |
| ------------ | ------------ | ------------------------------------------------------------------------------           |
| `make tikz`  | `f=filename` | Create a standalone `.tex` containing a tikz picture here `ressources/tikz/filename.tex` |


### Tikz

You should create one .tex file for each Tikz picture with the standalone class as below.

``` tex
\documentclass[12pt,tikz]{standalone}

\ifstandalone%
    \usepackage{import}
    \import{../../configuration/}{comon_packages.tex}%
    \import{../../configuration/}{variables.tex}%
    \import{../../configuration/}{conftikz.tex}%
    \import{../../configuration/}{custom_config.tex}%
\fi

\begin{document}
    \begin{tikzpicture}
        \draw[->, >=latex] (0, 0) -- (0, 1);
    \end{tikzpicture}
\end{document}
```

This file should be located in the `ressources/tikz/` directory. This permit to compile this file on its own. Alternatively, you can use `make tikz f=filename` to create a this tikz file.

To include it into your document, you could use `\includestandalone` like below.

``` tex
\begin{figure}[ht]
    \centering
    \includestandalone{filename}
    \caption{Caption}%
    \label{fig:label}
\end{figure}
```

But it will compile each time you make your main file and it will not work for subfiles for some reasons.

You should instead generate a pdf from this tikz file (using `make pdf f=filename t=tikz`). It will create the file `filename.pdf` in the same directory (`ressources/tikz`).

You can then include it using `\includegraphics`.

``` tex
\begin{figure}[ht]
    \centering
    \includegraphics{filename}
    \caption{Caption}%
    \label{fig:label}
\end{figure}
```

It will produce the exact same output but with no compilation time.


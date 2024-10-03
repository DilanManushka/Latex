\def\filename{UoWthesis}
\def\fileversion{v2.2}
\def\filedate{99/04/02}
%-----------------------------------------------------------------------
% UoWthesis.cls  -- by ASR, Physics Dept, Waikato University, NZ
%
% -- based on:
%
% ADFATHESIS.CLS by Stephen Harker, Dept. of Physics, ADFA: 12-JUN-94
%-----------------------------------------------------------------------
% This is based on the Monash University version of SUTHESIS.STY called
% MONTHESIS.STY by Tony McGrath, Dept. of Physics, Monash Uni: 5-NOV-87
% and the ADFATHESIS.STY that was/is on ccadfa.cc.adfa.oz.au
%-----------------------------------------------------------------------
% PhD thesis style -- modifications to the REPORT class:
% Style information from the `1993 Handbook' for the University College
% known as the `Blue Book', see pages 168 to 170.  Updated for 1997. 
%-----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\filename}[\filedate\space\fileversion\space%
         UoW thesis class]

%+++
% New commands: ASR
%---
\newif\ifFinalRun
\FinalRuntrue		% default: disable verbatim boxed labels

% Define vlabel (verbatim label in a box)
% \newcommand\vlabel[1]{\@gobble #1}
\newcommand\vlabel[1]{\label{#1}%
\ifFinalRun %
\else
	\fbox{\scriptsize #1}%	% verbatim ref string, in box
\fi}

%--------------------------------------------------------------------
% 6-Aug-2000  ASR: Attempt to reduce vertical spacing surrounding 
% AMSMath's \intertext{}

% Following code annexed from
% /usr/local/teTeX/texmf/tex/latex/amslatex/amsmath.sty

% \def\intertext{\@amsmath@err{\Invalid@@\intertext}\@eha}
% \def\intertext@{%
%   \def\intertext##1{%
%     \ifvmode\else\\\@empty\fi
%     \noalign{%
%       \penalty\postdisplaypenalty\vskip\belowdisplayskip
%       \vbox{\normalbaselines
%         \ifdim\linewidth=\columnwidth
%         \else \parshape\@ne \@totalleftmargin \linewidth
%         \fi
%         \noindent##1\par}%
%       \penalty\predisplaypenalty\vskip\abovedisplayskip%
%     }%
% }}

%------------------------
% 16-Feb-2000: From MJC, mapping from mathletters to subequations

\newenvironment{mathletters}{\subequations}{\endsubequations}

%-----------------------------------------------------------------------
% 12-Apr-89  New flag for draft printing
%  At this stage all I do is reset the page style
%-----------------------------------------------------------------------
\newif\ifdr@ft         % Enable various commands during initial write-up
\dr@ftfalse            % Not draft, by default, must be set in ROOT file
\newif\if@harvbib      % Use Harvard bib package?
\@harvbibtrue          % Harvard true by default, must be set in ROOT file

\DeclareOption{draft}
   {\dr@fttrue
    \PassOptionsToClass{draft}{report}}
\DeclareOption{normalbib}
   {\@harvbibfalse}
\DeclareOption{harvard}
   {\@harvbibtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[a4paper]{report}
\if@harvbib\RequirePackage{harvard}\fi

%-----------------------------------------------------------------------
% Set spacing for space and a half, using values from setspace.sty.
% Use the new \linespread command rather than 
% \renewcommand{\baselinestretch}{1.25} etc.
%-----------------------------------------------------------------------
\ifcase \@ptsize \relax % 10pt
  \linespread{1.25}%
\or % 11pt
  \linespread{1.213}%
\or % 12pt
  \linespread{1.241}%
\fi

%-----------------------------------------------------------------------
% Next two sections taken from setstretch.
%-----------------------------------------------------------------------

%---Stretch the baseline BEFORE calculating the strut size. This improves
%   spacing below tabular environments etc., probably...
%   Comments are welcomed.

\def\@setsize#1#2#3#4{%
  % Modified 1993.04.07--GDG per KPC
  \@nomath#1%
  \let\@currsize#1%
  \baselineskip #2%
  \baselineskip \baselinestretch\baselineskip
  \parskip \baselinestretch\parskip
  \setbox\strutbox \hbox{%
    \vrule height.7\baselineskip depth.3\baselineskip width\z@}%
  \skip\footins \baselinestretch\skip\footins
  \normalbaselineskip\baselineskip#3#4}
%
% Fix up spacing before and after displayed math
% (arraystretch seems to do a fine job for inside LaTeX displayed math,
% since array and eqnarray seem to be affected as expected).
% Changing \baselinestretch and doing a font change also works if done here,
% but then you have to change @setsize to remove the call to @nomath)
%
% \everydisplay\expandafter{%
%   \the\everydisplay
%   \abovedisplayskip \baselinestretch\abovedisplayskip
%   \belowdisplayskip \abovedisplayskip
%   \abovedisplayshortskip \baselinestretch\abovedisplayshortskip
%   \belowdisplayshortskip \baselinestretch\belowdisplayshortskip
% }
%-----------------------------------------------------------------------
%  Following changed by Stephen Harker, October 1993 to:
%  (i)   Make Chapter title centred, and modify size to \Large not
%        \Huge, use small caps for `chapter' and rules above and 
%        below.  Rule thickness defined by new length \chaprule.
%        To change this use \setlength.
%  (ii)  Make corresponding reductions to size of section,
%        subsection and subsubsection headers.
%  (iii) Rename Bibliography section to References.
%
%  Another change is to add \thesistype which can be defined
%  as appropriate for Masters or Doctoral thesis (default Doctoral).
%-----------------------------------------------------------------------
\newlength{\chaprule}    % Forced to be less than 6 points below!
\setlength{\chaprule}{0.4\p@}
%%%
%%% ASR: Restored original report.sty chapterhead definitions, but
%%% made minor changes to font size and style
%%%
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{20\p@}%
  {\parindent \z@ \raggedleft \normalfont
    \ifnum \c@secnumdepth >\m@ne
       \textsf{\LARGE\bfseries \@chapapp\space \thechapter}
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
	\raggedright
    \Huge \textsf{\bfseries #1}\par\nobreak
    \vskip 40\p@
  }}
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \textsf{\bfseries #1}\par\nobreak
    \vskip 40\p@
  }}

%%%
%%% ASR: Previous re-definitions removed
%%%
\ifnum 0=1
\renewcommand{\@makechapterhead}[1]{%
  \ifdim\chaprule>6\p@ \setlength{\chaprule}{6\p@}\fi
  \vspace*{10\p@ \@minus \chaprule}%
  \noindent\rule{\textwidth}{\chaprule}\par%
  \vskip 10\p@ \@plus\p@
  {\parindent \z@ \centering \normalfont
    \ifnum \c@secnumdepth >\m@ne
     {\Large\scshape \@chapapp\space \thechapter}
     \par\nobreak
     \vskip 8\p@ 
    \fi
    \interlinepenalty\@M
    \Large #1\par\nobreak
    \vskip 6\p@
    \noindent\rule{\textwidth}{\chaprule}\par%
    \vskip 10\p@ \@minus \chaprule
  }}
\renewcommand{\@makeschapterhead}[1]{%
  \ifdim\chaprule>6\p@ \setlength{\chaprule}{6\p@}\fi
  \vspace*{10\p@ \@minus \chaprule}%
  \noindent\rule{\textwidth}{\chaprule}\par%
  \vskip 10\p@ \@plus\p@
  {\parindent \z@ \centering
    \normalfont
    \interlinepenalty\@M
    \Large #1\par\nobreak
    \vskip 6\p@
    \noindent\rule{\textwidth}{\chaprule}\par%
    \vskip 10\p@ \@minus \chaprule
  }}
\fi % \ifnum
%
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
    {-4.5ex \@plus-1ex \@minus -.2ex}{1.5ex \@plus.2ex}%
    {\linespread{1}\normalfont\Large\sffamily\bfseries\boldmath\raggedright}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
    {-3.5ex \@plus -.5ex \@minus-.2ex}{1.0ex \@plus.1ex}%
    {\normalfont\large\sffamily\bfseries\boldmath\raggedright}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
    {-2.0ex\@plus -.5ex \@minus -.2ex}{1.0ex \@plus .1ex}%
	{\normalfont\normalsize\sffamily\bfseries\boldmath\raggedright}}
\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
    {1.0ex \@plus.5ex \@minus.2ex}{-1em}%
    {\normalfont\normalsize\itshape\bfseries\boldmath\raggedright}}
\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\parindent}%
    {1.0ex \@plus.5ex \@minus .2ex}{-1em}%
    {\normalfont\normalsize\itshape\raggedright}}
%
%%% ASR
%
% Original definitions from report.cls:
\ifnum 0=1
\newcommand\section{\@startsection {section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex}%
	{\normalfont\Large\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}%
	{\normalfont\large\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}%
	{\normalfont\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
	{3.25ex \@plus1ex \@minus.2ex}{-1em}%
	{\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
	{3.25ex \@plus1ex \@minus .2ex}{-1em}%
	{\normalfont\normalsize\bfseries}}
\fi % \ifnum

\renewcommand{\bibname}{References}

%-----------------------------------------------------------------------
% Taken from sober.sty, Nico Poppelier and rapport1.cls (NTG classes).
% Makes list (enumerate and itemize) more reasonable in vertical space,
% by adjusting the spacing between items.
%-----------------------------------------------------------------------
\def\@listi{\leftmargin\leftmargini
    \labelsep .5em%
    \labelwidth\leftmargini
    \advance\labelwidth-\labelsep
    \parsep \z@
    \topsep 0.4ex \@plus\p@ 
    \itemsep 0\p@ \@plus1\p@}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
    \labelsep .5em%
    \labelwidth\leftmarginii
    \advance\labelwidth-\labelsep
    \topsep 0\p@ \@plus\p@
    \parsep \z@ \@plus\p@
    \itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
    \labelsep .5em%
    \labelwidth\leftmarginiii
    \advance\labelwidth-\labelsep
    \topsep 0\p@ \@plus\p@
    \parsep \z@
    \partopsep \z@ \@plus\p@
    \itemsep \topsep}
\def\@listiv{\leftmargin\leftmarginiv
    \labelsep .5em%
    \labelwidth\leftmarginiv
    \advance\labelwidth-\labelsep
    \topsep 0\p@ \@plus\p@
    \parsep \z@
    \partopsep \z@ \@plus\p@
    \itemsep \topsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelsep  .5em%
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep%
              \topsep    0\p@ \@plus\p@
              \parsep    \z@
              \itemsep   \z@ \@plus\p@}
\def\@listvi {\leftmargin\leftmarginvi
              \labelsep  .5em
              \labelwidth\leftmarginvi
              \advance\labelwidth{-\labelsep}%
              \topsep    0\p@ \@plus\p@
              \parsep    \z@
              \itemsep   \z@ \@plus\p@}

%-----------------------------------------------------------------------
%  Reduce widow/orphan problems, mainly from a posting from Donald
%  Arsenau on comp.text.tex, 24 Sep 1995.
%-----------------------------------------------------------------------
\raggedbottom
\setlength{\topskip}{1\topskip \@plus 5\p@}
\doublehyphendemerits=10000     % No consecutive line hyphens.
\brokenpenalty=10000            % No broken words across columns/pages.
\widowpenalty=9999              % Almost no widows at bottom of page.
\clubpenalty=9999               % Almost no orphans at top of page.
\interfootnotelinepenalty=9999  % Almost never break footnotes.

%-----------------------------------------------------------------------
% Change float placement parameters to reduce problems.  Based on
% values posted by Donald Arsenau on comp.text.tex at various times.
% See in particular 17th Nov 1997.
%-----------------------------------------------------------------------
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}

%-----------------------------------------------------------------------
%  Make tables and figures default to small text and be single spaced,
%  and modify caption macro to allow this to take effect in the caption.
%  Use this version rather than previous redefinition of \@xfloat, see
%  setspace.sty for an improved example of the latter.
%  From comp.text.tex, Donald Arsenau 25 July 1996.
%
%  ASR: Moved the table and figure @float{} commands to front of 
%  definition, otherwise the \small font request didn't work!
%
%  Oct 28, 1999: Further change required to handle optional position
%  specifier (e.g., [t,b,H]) with magic provided by M. Cree

%-----------------------------------------------------------------------
\def\myfontsize{\small}

% MJC update: 
\renewenvironment{table}[1][\fps@table]%
	{\@float{table}[#1]\linespread{1}\normalfont\myfontsize}
  {\end@float}

% previous ASR version:
%\renewenvironment{table}
  %%	{\linespread{1}\normalfont\small\@float{table}}  % didn't work!
%	{\@float{table}[t!]\linespread{1}\normalfont\myfontsize}
%	{\end@float}

\renewenvironment{table*}[1][\fps@table]%
	{\@dblfloat{table*}[#1]\linespread{1}\normalfont\myfontsize}
	{\end@dblfloat}
\renewenvironment{figure}[1][\fps@figure]%
	{\@float{figure}[#1]\linespread{1}\normalfont\myfontsize}
	{\end@float}
\renewenvironment{figure*}[1][\fps@figure]%
	{\@dblfloat{figure*}[#1]\linespread{1}\normalfont\myfontsize}
	{\end@dblfloat}
\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
%%  \normalsize   % Remove this so we can get \small captions.
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

% ASR: 5-May-2001: Define a manual \caption command which does not
% update the List of Figures or Table of Contents 
% Usage: \@manualcaption{bold text}{normal text}
%  (intended for a caption-continuation for a multipage figure)

\long\def\@manualcaption#1#2{\par
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \@makecaption{#1}{\ignorespaces #2}\par
  \endgroup}

% Also Donald Arsenau's modified \@makecaption which fixes problems
% with spacing of captions before tables.  Taken from comp.text.tex
% 21 May 1997.  Regular version (acts like regular caption, but with
% Donald Arsenau's improvements)
% ASR: Added \textbf{} to make the label bold

% ASR: 10-Sept-00: Reduce \abovecaptionskip from 10pt default
% \setlength\abovecaptionskip{10\p@} 
\setlength\abovecaptionskip{0\p@}

\def\onecaptflag{268 }
\long\def\@makecaption#1#2{\let\@tempa\relax
   \ifdim\prevdepth>-99\p@ \vskip\abovecaptionskip \relax 
   \else \def\@tempa{\vbox to\topskip{}}\fi
   \textbf{#1: }\@tempa \vadjust{\penalty \onecaptflag}#2\par
   \ifnum\lastpenalty=\onecaptflag
      \unpenalty \setbox\@tempboxa\lastbox
      \nointerlineskip
      \hbox to\hsize{\hskip\parfillskip\unhbox\@tempboxa}%
   \fi \vskip\belowcaptionskip}
%-----------------------------------------------------------------------
% Number figures, tables and equations by chapter.  Re-define footnotes
% and minipage footnotes to be single spaced.  Make new macros needed
% for thesis definitions.
%-----------------------------------------------------------------------

\renewcommand{\thefigure}{\thechapter.\@arabic\c@figure}
\renewcommand{\thetable}{\thechapter.\@arabic\c@table}
\renewcommand{\theequation}{\thechapter.\@arabic\c@equation}

% Re-define \@footnotetext and \@mpfootnotetext to use single spacing
% rather than the space-and-a-half that is the default elsewhere.

\renewcommand{\@footnotetext}[1]{%
  \insert\footins{%
    \linespread{1}\normalfont\footnotesize%
    \interlinepenalty\interfootnotelinepenalty 
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth 
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}

\renewcommand{\@mpfootnotetext}[1]{%
  \global\setbox\@mpfootins\vbox{%
    \unvbox \@mpfootins
    \linespread{1}%
    \normalfont\footnotesize
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
       \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
   \color@endgroup}}

%-----------------------------------------------------------------------
% Define thesis related commands.
%-----------------------------------------------------------------------
\newcommand{\dept}[1]{\gdef\@dept{#1}}
\newcommand{\thesistype}[1]{\gdef\@thesistype{#1}}
\newcommand{\principaladviser}[1]{\gdef\@principaladviser{#1}}
\newcommand{\advis@r}{Adviser}
\newcommand{\principaladvisor}[1]{\gdef\@principaladviser{#1}%
        \gdef\advis@r{Advisor}}
\newcommand{\firstreader}[1]{\gdef\@firstreader{#1}}
\newcommand{\secondreader}[1]{\gdef\@secondreader{#1}}
\newcommand{\submitdate}[1]{\gdef\@submitdate{#1}}
\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1}} % \author, \title
                                                         % in report 

\renewcommand{\@title}{}
\renewcommand{\@author}{}
\newcommand{\@dept}{Physics}
\newcommand{\@thesistype}{Doctor of Philosophy}
\newcommand{\@principaladviser}{}
\newcommand{\@firstreader}{}
\newcommand{\@secondreader}{}
\newcommand{\@submitdate}{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\ifnum\month=12
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \newcommand{\@copyrightyear}{\number\the\year}
\fi

\newif\ifcopyright
\newif\iffigurespage
\newif\iftablespage
\newif\ifsymbolspage
\newif\ifacronymspage

\copyrightfalse
\figurespagefalse
\tablespagefalse
\symbolspagefalse
\acronymspagefalse
%-----------------------------------------------------------------------
% A new definition, mainly for the DECLARATION.
%-----------------------------------------------------------------------
\newcommand{\authornameonly}[1]{\gdef\Authornameonly{#1}}
%-----------------------------------------------------------------------
% Title page, copyrightpage and declaration page definitions.
%-----------------------------------------------------------------------
\newcommand{\titlep}{%
        \pagestyle{empty}%
        \null\vskip2.5cm%
        \begin{center}
%               \textsf{\bfseries\LARGE\uppercase\expandafter{\@title}}
                \textsf{\bfseries\huge \@title}
        \end{center}
        \vfill
        \begin{center}
                {\scshape A thesis submitted for the degree of \\
                \expandafter{\@thesistype}}
        \end{center}
        \vfill
        \begin{center}
                {\rmfamily\normalsize by\\
                \@author}\\
        \end{center}
        \vfill
        \begin{center}  
                {\rmfamily\normalsize Department of \expandafter{\@dept}\\
                The University of Waikato \\
                Hamilton, New Zealand} \\
                \vskip1cm
                {\rmfamily\normalsize \@submitdate}\\
        \end{center}
        \vskip1cm
        \newpage}

\newcommand{\copyrightpage}{%
		\pagestyle{empty}%
        \null\vfill
        \begin{center}
                {\normalsize\copyright\ Copyright \@copyrightyear\\
                by\\
                \@author}\\
        \end{center}
        \vskip2cm\newpage}

\newcommand{\declaration}{% 
\newpage 
\null\vfill 
\begin{center}
\begin{minipage}{11cm} 
\setlength{\parindent}{0\p@} 
\setlength{\parskip}{2ex \@plus0.5ex} 
{\rmfamily\normalsize 
{\large Certificate of Originality}
\vskip0.5cm

I hereby declare that this submission is my own work and that, to the
best of my knowledge and belief, it contains no material previously
published or written by another person nor material which to a
substantial extent has been accepted for the award of any other degree
or diploma of a university or other institute of higher learning,
except where due acknowledgement is made in the text.

I also declare that the intellectual content of this thesis is the
product of my own work, even though I may have received assistance
from others on style, presentation and language expression.}
\par 
\vspace{2.5cm}
\mbox{}\hfill\Authornameonly 
\end{minipage} 
\end{center} 
\vfill\null
\addcontentsline{toc}{chapter}{Declaration}}

%-----------------------------------------------------------------------
% ASR: Add definitions for \listofsymbols and \listofacronyms
% (not needed!!)
%-----------------------------------------------------------------------
\newcommand\listsymbolname{Symbol Definitions}
\newcommand\listofsymbols[1]{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listsymbolname
      \@mkboth{\MakeUppercase\listsymbolname}%
              {\MakeUppercase\listsymbolname}}%
	\input{#1}%
   x\if@restonecol\twocolumn\fi
    }
%
\newcommand\listacronymname{Acronyms and Abbreviations}
\newcommand\listofacronyms[1]{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listacronymname
      \@mkboth{\MakeUppercase\listacronymname}%
              {\MakeUppercase\listacronymname}}%
	\input{#1}%
	\addcontentsline{toc}{chapter}{\listacronymname}  %%% ASR
    \if@restonecol\twocolumn\fi
    }

%-----------------------------------------------------------------------
% Add definitions for \beforepreface, \prefacesection and \afterpreface 
% to allow page numbering and headerstyle to be changed.
%-----------------------------------------------------------------------
\newcommand{\beforepreface}{%
        \pagestyle{empty}
        \titlep
        \ifcopyright\copyrightpage\fi
        \if@twoside\cleardoublepage\fi
        \pagenumbering{roman}
        \ifdr@ft\pagestyle{draft}\else\pagestyle{plain}\fi
        \setcounter{page}\@ne% Reset the page number to 1, i.e. titlepage is page 0
        }

% For two-sided printing, most preface-section entries should start on
% right-hand page.  However, wish to allow Acknowledgements to print on 
% either left- or right-hand page, so don't force a \cleardoublepage

\newcommand{\prefacesection}[1]{%
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}
}
\newcommand{\afterpreface}{%
		\newpage
        \if@twoside
           \pagestyle{empty}\cleardoublepage
        \fi
%
        \tableofcontents
		\newpage
        \if@twoside
           \pagestyle{empty}\cleardoublepage
        \fi
        \iftablespage
                \listoftables
				\addcontentsline{toc}{chapter}{\listtablename}  %%% ASR
                \newpage
				\if@twoside
                  \pagestyle{empty}\cleardoublepage
                \fi
        \fi
%        \iftablespage
%                {\addvspace{10\p@}
%                \let\saveaddvspace=\addvspace
%                \def\addvspace##1{}
%                \listoftables
%				\addcontentsline{toc}{chapter}{\listtablename}  %%% ASR
%                \let\addvspace=\saveaddvspace}
%                \newpage
%				\if@twoside
%                  \pagestyle{empty}\cleardoublepage
%                \fi
%        \fi
        \iffigurespage
                {\addvspace{10\p@}
                \let\saveaddvspace=\addvspace
                \def\addvspace##1{}
                \listoffigures
				\addcontentsline{toc}{chapter}{\listfigurename}  %%% ASR
                \let\addvspace=\saveaddvspace}
                \newpage
				\if@twoside
                  \pagestyle{empty}\cleardoublepage
                \fi
        \fi
        \ifsymbolspage
                {\addvspace{10\p@}
                \let\saveaddvspace=\addvspace
                \def\addvspace##1{}
   %             \listofsymbols{d.tex}
    \chapter*{\listsymbolname}
			\addcontentsline{toc}{chapter}{\listsymbolname}  %%% ASR
                \let\addvspace=\saveaddvspace}
                \newpage
				\if@twoside
                  \pagestyle{empty}\cleardoublepage
                \fi
        \fi
        \ifacronymspage
                {\addvspace{10\p@}
                \let\saveaddvspace=\addvspace
                \def\addvspace##1{}
    \chapter*{\listacronymname}
				\addcontentsline{toc}{chapter}{\listacronymname}  %%% ASR
                \let\addvspace=\saveaddvspace}
                \newpage
				\if@twoside
                  \pagestyle{empty}\cleardoublepage
                \fi
        \fi
        \pagenumbering{arabic}
        \ifdr@ft\pagestyle{draft}\else\pagestyle{plain}\fi}
%-----------------------------------------------------------------------
% Create a brand new page style to include the date in the page header.
%-----------------------------------------------------------------------
\newcommand{\ps@draft}{%\let\@mkboth\@gobbletwo
     \renewcommand{\@oddfoot}{\@empty}%
     \renewcommand{\@oddhead}{\rmfamily\slshape\today\hfil\thepage}%
     \renewcommand{\@evenhead}{\rmfamily\slshape\thepage\hfil\today}%
     \renewcommand{\@evenfoot}{\@oddfoot}}
%-----------------------------------------------------------------------
% Start with pagestyle{plain} in case front matter isn't processed
%-----------------------------------------------------------------------
\pagestyle{plain}

%***********************************************************************
% Modify Table of contents entry for chapter to normal font not bold.
% Second use word Chapter/Appendix before number.  Use \appendixname
% rather than \@chapapp to set width for this element as it is longer!
%***********************************************************************
\newlength{\@chapwidth}%
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \settowidth{\@chapwidth}{\appendixname}% not \@chapapp
    \addtolength{\@chapwidth}{\@pnumwidth}
    \setlength\@tempdima{\@chapwidth}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \normalfont
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
       \refstepcounter{chapter}%
       \typeout{\@chapapp\space\thechapter.}%
       \addcontentsline{toc}{chapter}%
       {\protect\numberline{\expandafter{\@chapapp}\space\thechapter}#1}%
    \else
       \addcontentsline{toc}{chapter}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%
    \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
    \else
    \@makechapterhead{#2}%
    \@afterheading
    \fi}

\endinput
%----------------------------------------------------------------------------
% Documentation
%----------------------------------------------------------------------------
\documentclass{article}
\title{The \texttt{adfathesis} class}
\author{Stephen Harker}
\date{25 May 1997}

\begin{document}
\maketitle

Some basic information on the use of \texttt{adfathesis} (a
modification of the \texttt{SUthesis} style) follows.  This class file
can only be used under \LaTeXe.  An example of use is shown below:

\begin{quote}
\small
\begin{verbatim}
\documentclass[a4paper,12pt]{adfathesis}

% Control which chapters in LaTeX'd in this run with
\includeonly{chapter1,chapter2,chapter3}

\title{How to Write Theses\\
       With Two Line Titles}
\authornameonly{John Henry Candidate}
\author{\Authornameonly \\ B.Sc.(Hons)}
\copyrightfalse    % No copyright page
\figurespagefalse  % No List of Figures
\tablespagefalse   % No List of Tables

\begin{document}
\beforepreface
\prefacesection{Abstract}
    This thesis tells you all you need to know about...
\declaration      % Declaration page.
\prefacesection{Acknowledgements}
    I would like to thank...
\afterpreface
 
\include{chapter1}  % Introduction
         ...
\include{chapter6}  % Conclusions
         ...
\appendix
\include{appendix1} % A Long Proof
         ...
\clearpage                                        % Needed to get page
\addcontentsline{toc}{chapter}{References}        % in TOC correct.
\bibliographystyle{adfathesis}
\bibliography{mybib}
\end{document}
\end{verbatim}
\end{quote}

\textbf{Documentation}: This class modifies the standard report class
to meet the \textsc{adfa} requirements given in the `\emph{University
College Handbook}'.  It sets the margins, interline spacing, the
figure and table numbering style, and disallows page breaks at
hyphens.

The `\texttt{\bs{}beforepreface}' command creates the title page, a
copyright page (optionally), and the table of contents.  Then the user
should put preface section(s), using the command
`\texttt{\bs{}prefacesection\{}{\em section title\/}\texttt{\}}', this
should include the declaration page.  The `\texttt{\bs{}afterpreface}'
command then produces the tables of tables and figures, and sets
things up to start the main body (on arabic page~1).

The following commands can control what goes in the front matter
material:
\begin{description}
\small
\item{\ttfamily\bs{}title\{{\em thesis title\/}\}} Title of the thesis.
\item{\ttfamily\bs{}authornameonly\{{\em name\/}\}} The author's name
  without degrees earned, needed for the declaration.
\item{\ttfamily\bs{}author\{{\em name\/}\}} The author's name with degrees
  earned, for the titlepage.
\item{\ttfamily\bs{}dept\{{\em department\/}\}} The default value is
  Department of `{\em Physics}'.
\item{\ttfamily\bs{}thesistype\{{\em Type of thesis\/}\}} The default value
  is `{\em Doctor of Philosophy\/}'.
\item{\ttfamily\bs{}submitdate\{{\em date\/}\}} Month and year in which
  submitted; date \LaTeX{}'d if omitted.
\item{\ttfamily\bs{}copyrightyear\{{\em year\/}\}} Year degree conferred, or
  year \LaTeX{}'d if omitted (next year if in December).
\item{\ttfamily\bs{}declaration} Produce the required declaration that the
  thesis is all the author's own work.
\item{\ttfamily\bs{}copyrighttrue} Produce or \texttt{\bs{}copyrightfalse}
  don't produce a `{\em copyright\/}' page (true by default).
\item{\ttfamily\bs{}figurespagetrue} Produce or
  \texttt{\bs{}figurespagefalse} don't produce a `{\em List of Figures\/}'
  page (true by default).
\item{\ttfamily\bs{}tablespagetrue} Produce or
  \texttt{\bs{}tablespagefalse} don't produce a `{\em List of Tables}'
  page (true by default).
\end{description}

This class uses space and a half interline spacing, except in
footnote, figure and table environments where normal spacing is
used. The command: `\texttt{\bs{}linespread\-\{1.655\}}' can be used
to change this (use whatever you want instead of 1.655).  For 12 point
Computer Modern fonts 1.241 corresponds to space and a half, and 1.655
to double spacing.  This command should be given in the preamble
(i.e.\ before the `\texttt{\bs{}begin\{document\}}').

The example given shows the \textsf{12pt} option being used.  This is
required by the 1997 handbook, but may be omitted (at your own risk)
to get smaller print.  There are two options which may be declared
in \texttt{\bs{}documentclass[a4paper,12pt]\{adfathesis\}}:
\begin{itemize}
\item \texttt{draft} which changes the pagestyle to include the date
on the page header.
\item \texttt{normalbib} which stops the document using the
\textsf{Harvard} style, and hence allows use of either the standard
\LaTeX\ bibliography style or an alternative package.  The supplied
\texttt{adfathesis.bst} may not be appropriate in this case.
such as \texttt{plain.bst}.
\end{itemize}

To get the correct page number for the bibliography in the table of
contents you need to put a `\texttt{\bs{}clearpage}' command before
the `\texttt{\bs{}addcontentsline}' command (as shown above).  The
thickness of the rules used for the chapter headings is controlled by
`\texttt{\bs{}chaprule}' and can be set to another value, say 0~pt, by
the command `\texttt{\bs{}setlength\{\bs{}chaprule\}\{0pt\}}' in the
preamble.  There is a maximum value of 6~pt for
`\texttt{\bs{}chaprule}'.

\end{document}

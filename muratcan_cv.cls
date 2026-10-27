% Created by Murat Can Karacabey
% this is inspired by Michael Pollind's Awesome CV 
% Created from scratch as a much simpler alternative to it to actually learn LaTeX.
% Might be interpreted as an easier-to-edit or easier-to-understand-what-is-going-on version of it.
\author{Dylan Festa}
\RequirePackage[dvipsnames,svgnames]{xcolor} % moved here I guess article class causes option clash with xcolor if used after loading the class
\LoadClass[11pt]{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{muratcan_cv}[2020/04/15 Muratcan CV Class]
\RequirePackage[sfdefault]{noto}
\RequirePackage{etoolbox}
\RequirePackage{pgffor}
\RequirePackage{titlesec}
\RequirePackage{tikz}
\RequirePackage{fontspec}
\RequirePackage[left=0.75in,top=0.3in,right=0.75in,bottom=0.6in]{geometry} % Document margins
\RequirePackage{hyperref}
\RequirePackage{fontawesome5}
\RequirePackage{mfirstuc}
\RequirePackage{ifthen}
\RequirePackage{lipsum}
\RequirePackage{array}
\pagestyle{empty}
\setlength{\parindent}{0pt} % No first-line indentation anywhere in the CV.

%Setup

\usepackage{academicons}
\definecolor{orcidlogocol}{HTML}{A6CE39}

\newcommand*{\setname}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\setaddress}[1]{\def\@address{#1}}
\newcommand*{\setmobile}[1]{\def\@mobile{#1}}
\newcommand*{\setposition}[1]{\def\@position{#1}}
\newcommand*{\setmail}[1]{\def\@mail{#1}}
\newcommand*{\setthemecolor}[1]{\def\@themecolor{#1}}
\newcommand*{\setlinkedinaccount}[1]{\def\@linkedinaccount{#1}}
\newcommand*{\setgithubaccountlink}[1]{\def\@githubaccountlink{#1}}
\newcommand*{\setgithubaccountname}[1]{\def\@githubaccountname{#1}}
\newcommand*{\setmastodonlink}[1]{\def\@mastodonlink{#1}}
\newcommand*{\setmastodonname}[1]{\def\@mastodonname{#1}}

%Setup for coverletter

\newcommand*{\setcompanyname}[1]{\def\@companyname{#1}}
\newcommand*{\setcontactperson}[1]{\def\@contactperson{#1}}
\newcommand*{\setclaimedposition}[1]{\def\@claimedposition{#1}}

\colorlet{mylinkscolor}{SlateBlue}

\hypersetup{
    colorlinks=true,
    urlcolor=mylinkscolor,
}

% View commands
% Header

% can makebox also be used?
\newcommand\headerview{
\begin{minipage}{0.25\linewidth}
    \profpic{0.08}{images/profilepicture}
\end{minipage}% 
\hfill
\begin{minipage}{0.6\linewidth}
    \centering
    \small
    \begin{tabular}{@{}r@{\cps}l@{}}
        \name & {\footnotesize \dylanorcid} \\[0.05cm]
        \contact
    \end{tabular}
\end{minipage}
}

%profilpicture

\newsavebox{\picbox}
\newcommand{\profpic}[2]{%
    \savebox{\picbox}{%
    \includegraphics[scale=#1]{#2}}%
    \tikz\node [draw, circle,%
    line width=4pt, color=white,% 
    minimum width=\wd\picbox,minimum height=\ht\picbox,%
    path picture={ \node at (path picture bounding box.center)% 
    {\usebox{\picbox}};}]% 
    {};}
    
%contactsubviews 
    
    
\newcommand{\linkedinview}{\href{\@linkedinaccount}{\faLinkedin\ \footnotesize linkedin}}
\newcommand{\githubview}{\href{\@githubaccountlink}{\faGithubSquare\ \footnotesize \@githubaccountname}}
\newcommand{\mastodonview}{\href{\@mastodonlink}{\faMastodon\ \footnotesize \@mastodonname}}
\newcommand{\dylanorcid}{\href{https://orcid.org/0000-0003-3803-1542}{\textcolor{orcidlogocol}{\aiOrcid}~0000-0003-380}}

\newcommand{\name}{%
    {\large \@firstname \ \textsc{\@lastname}}%
}


% \newcommand{\contact}{%
%         {\small \@address  \cps \@mobile \\ \@mail%
%         \\%
%         \linkedinview \cps \githubview \\ 
%         } % 
% }

\newcommand{\contact}{%
        \@mail & \mastodonview \\
        \@mobile & \githubview \\
}
% Covverletterview

\newcommand\coverletter[1]{ 
\\  \coverlettersubview 
\section{} \vspace{1ex} 
\textbf{ Dear \@contactperson, \\[0.1cm]}
  #1
}

\newcommand\coverlettersubview{
\begin{tabular}{>{\scshape \bfseries \color{\@themecolor}}l  >{\small }l}
Company: & \@companyname \\
Position: & \@claimedposition \\
\end{tabular}
}


% Helper commands

\newcommand\ruleafter[1]{#1~{\color{black!60!\@themecolor}\hrulefill}} % a trick to put the line with <before> parameter in \titleformat

%colorfulpipeseperator

\newcommand{\cps}{{\color{\@themecolor} \quad\textbar\quad}}
\newcommand{\cpshalf}{{\color{\@themecolor} \hspace{0.2em}\textbar\hspace{0.2em}}}

\newcommand{\coloredbullet}{{\color{\@themecolor} \textbullet}}

% Edit section styles

\titleformat{\section}      % Customise the \section command 
  {\large\bfseries\scshape\raggedright\color{\@themecolor}} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {\ruleafter}                           % Can be used to insert code before the heading

\titlespacing*{\section}{-1pt}{0pt}{0pt}

% Textview commands

\newcommand{\experience}[2]{%
  \mbox{\scshape\textbf{#1}}%
}

\newcommand{\datetext}[1]{%
{\itshape  \footnotesize \mdseries  \color{black!60!\@themecolor} #1 } 
}

\newlength{\experiencegap}
\setlength{\experiencegap}{0.35em}

\newcommand{\datedexperience}[2]{%
  \par\addvspace{\experiencegap}\noindent
  {\small\mbox{\scshape\textbf{#1}}}\hfill \datetext{#2}\\*[0.01cm]%
}

\newcommand{\explanation}[1]{%
    \noindent
    \parbox[t]{\linewidth}{\raggedright\scshape\footnotesize #1}\par\nobreak\vspace{0.05cm}%
}

\newcommand{\explanationdetail}[1]{%
    \noindent\begin{minipage}{\linewidth}\footnotesize #1\end{minipage}\par\vspace{0.1cm}%
}

% Compact detail bullets: same font and outer spacing as \explanationdetail.
\newenvironment{explanationitems}{%
    \par\noindent\begin{minipage}{\linewidth}\footnotesize
    \begin{list}{\coloredbullet}{%
        \setlength{\leftmargin}{1.5em}%
        \setlength{\rightmargin}{0pt}%
        \setlength{\labelwidth}{0.5em}%
        \setlength{\labelsep}{0.5em}%
        \setlength{\itemindent}{0pt}%
        \setlength{\listparindent}{0pt}%
        \setlength{\topsep}{0pt}%
        \setlength{\partopsep}{0pt}%
        \setlength{\itemsep}{0pt}%
        \setlength{\parsep}{0pt}%
    }%
}{%
    \end{list}\end{minipage}\par\vspace{0.1cm}%
}

\newcommand{\itemwithtext}[1]{%
    \begin{minipage}{\linewidth} \footnotesize \item #1 \end{minipage}
}

\newcommand{\addblocktext}[2]{%
  \section{#1} 
  \explanationdetail{#2}
}

\newcommand\createskill[2]{%
    \textsc{\textbf{#1}} & #2
}

\newcommand\createtablecontent[1]{%
    \foreach \x [count=\xi] in {#1} {\ifthenelse{\xi=1}{\x}{\\ \x}}
}

\newcommand\createskillsanothertry[1]{%not used
  \begin{tabular}{r|l}
      \createtablecontent{#1}
        \end{tabular}
}

\newcommand\createskills[1]{%
\explanationdetail{
  \begin{tabular}{rl}
    \makeatletter
    \@for\thisitem:=#1\do{\thisitem\\[0.1cm]}
    \makeatother
    \end{tabular}
}
}

\newcommand\createbullets[1]{%
    \renewcommand{\labelitemi}{\coloredbullet}
  \begin{itemize}
    \makeatletter
    \@for\thisitem:=#1\do{\itemwithtext{\thisitem}}
    \makeatother
  \end{itemize}
}

\newcommand\createfootnote{%
  \renewcommand{\footnotesize}{\fontsize{7pt}{11pt}\selectfont}
    \renewcommand\footnoterule{\rule{0.3\linewidth}{0.5pt}}
    %\let\thefootnote\relax\footnote{\emph{last edit: \today}}}
    \let\thefootnote\relax\footnote{\scriptsize\color{gray}compiled from \LaTeX\ on: \today}}

   % \ / \href{https://github.com/muratcankaracabey/latex_cv}{source code}}}

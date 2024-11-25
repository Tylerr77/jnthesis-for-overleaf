% !Mode:: "TeX:UTF-8"
% !TeX encoding = UTF-8 Unicode
% !TeX program = xelatex

%% LaTeX2e class for student thesis of Jiangnan University
%% jnthesis.cls
%%
%% Bo Zhuang
%% bozhuang@jiangnan.edu.cn
%%
%% Version 0.1, 2019/04/21

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jnthesis}[2019/04/20 v0.1 Thesis class of Jiangnan University]

% \LoadClass[UTF8,zihao=-4,scheme=chinese,nonspace,punct,twoside,a4paper,openany,titlepage=true]{ctexbook} 	
% 原版注释这个会报错 Unused global option(s):[nonspace,titlepage]
\LoadClass[UTF8,zihao=-4,scheme=chinese,punct,twoside,a4paper,openany]{ctexbook}

\RequirePackage{hyperref} % 超链接
\RequirePackage{graphicx} % 插图
\RequirePackage{subfig}   % 子图
\RequirePackage{color}    % 颜色
\RequirePackage{enumerate}% 列表
\RequirePackage{enumitem}
\RequirePackage{amsmath}  % 数学公式 ([fleqn] 左对齐)
\RequirePackage{amssymb, amsfonts, mathrsfs, mathtools} % 数学字体符号
\RequirePackage[hyperref, thmmarks, amsmath]{ntheorem}  % 定理
\RequirePackage{algorithmicx,algpseudocode} % 算法伪代码
\RequirePackage{listings}  % 程序代码
\RequirePackage[square, super, comma, sort&compress]{natbib}   % 参考文献
\RequirePackage{lipsum}   % 乱数假文, 用于测试排版效果
\RequirePackage[final]{pdfpages} % 插入封面 PDF 文件

\RequirePackage{fontspec}  % 字体
\RequirePackage{xunicode}
\RequirePackage{setspace}  % 行距
\RequirePackage{emptypage} % 清空空白页
\RequirePackage{fancyhdr}  % 页眉页脚
\RequirePackage{titlesec}  % 标题格式
\RequirePackage{titletoc}  % 目录格式
\RequirePackage{ifthen}    % If-Then

% nice tables
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{hhline}
\RequirePackage{threeparttable}
\RequirePackage{siunitx}          % 国际单位

%% 标准文档类结构名重定义
\renewcommand{\partname}{第\chinese{part}部分}
\renewcommand{\chaptername}{第\arabic{chapter}章}
\renewcommand{\contentsname}{目~~录}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}
\renewcommand{\bibname}{参考文献}
\renewcommand{\abstractname}{摘~~要}

%% 毕业与学位
\def\jnmaster{硕士}
\def\jndoctor{博士}
\def\thedegree{\jndoctor} % 学位 (默认为博士)
\def\jndegree{学位}
% 若文档参数中包含 master 则设置为硕士学位
\DeclareOption{master}{\def\thedegree{\jnmaster}}
\DeclareOption{doctor}{\def\thedegree{\jndoctor}}
\DeclareOption{nodegree}{\def\jndegree{毕业}} % 毕业论文, 不申请学位
\ProcessOptions\relax

%% 中英文字体
% CTEX默认正文宋体，注释下面这句
% \setCJKmainfont[AutoFakeBold={2.17}, ItalicFont={楷体}]{宋体}
\setmainfont{Times New Roman}

% 链接样式
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  citecolor=blue,
}

% 引用样式
\providecommand{\citeit}[2][]{\unskip{\setcitestyle{numbers,square}\cite[#1]{#2}}}

%% 页边距
\RequirePackage[top=2cm,bottom=2cm,left=2.5cm,right=2.5cm]{geometry}

% 行距
\setstretch{1.25} % 默认 1.25 倍行距

%% 标题格式
% Chapter
\titleformat{\chapter}[hang]{\centering\setstretch{1}\heiti\zihao{3}}{\chaptertitlename}{10pt}{}{}
\titlespacing{\chapter}{0pt}{-0.2cm}{2.5ex plus .1ex minus .2ex}
% Section
\titleformat{\section}[hang]{\songti\zihao{4}\bf}{\thesection}{1em}{}{}
\titlespacing{\section}{0cm}{0.5cm}{0.5cm}
% Subsection
\titleformat{\subsection}[hang]{\songti\zihao{-4}\bf}{\thesubsection}{1em}{}{}
\titlespacing{\subsection}{0pt}{1.5ex plus .1ex minus .2ex}{\wordsep}
% Sub-subsection
\titleformat{\subsubsection}[hang]{\songti\zihao{-4}\bf}{\thesubsubsection}{1em}{}{}
\titlespacing{\subsubsection}{10pt}{1.2ex plus .1ex minus .2ex}{\wordsep}

%% 目录格式
\titlecontents{chapter}[0pt]{\songti\zihao{-4}}%
{\thecontentslabel\quad}{}%
{\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}

\titlecontents{section}[0pt]{\songti\zihao{-4}\hspace{1em}}%
{\thecontentslabel\quad}{}%
{\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}

\titlecontents{subsection}[0pt]{\songti\zihao{-4}\hspace{2em}}%
{\thecontentslabel\quad}{}%
{\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}

% 简单页面样式 (单一页眉, 页脚)
\newcommand{\samplepagestyle}[1]{
  \pagestyle{fancy}
  \fancyhead{}
  \fancyhead[CO,CE]{#1}
  \fancyfoot[C]{\thepage}
  \headsep=0.5cm
}

% 论文前页
\newcommand{\jnfrontmatter}{
  \frontmatter
  \pagenumbering{Roman}
  \samplepagestyle{}
  \fancypagestyle{plain}{ % 章节首页显示页眉
    \pagestyle{fancy}
  }
}
%% 摘要 \jnabstract[zh* | en]
\newcommand{\jnabstract}[1][zh]{
  \ifthenelse{\equal{#1}{en}}{
    \clearpage               % 新一页开始
    \samplepagestyle{\zihao{5}Abstract}   % 页面样式
    \chapter*{{\bf Abstract}}
    \addcontentsline{toc}{chapter}{Abstract}
  }{
    \clearpage               % 新一页开始
    \samplepagestyle{\songti\zihao{5}摘要}   % 页面样式
    \chapter*{\abstractname}
    \addcontentsline{toc}{chapter}{\abstractname}
  }
}

%% 关键词环境
% \begin{jnkeywords}[zh* | en]
% \sep 关键词分隔符
\newenvironment{jnkeywords}[1][zh]{
  \ifthenelse{\equal{#1}{en}}{
    \vspace{0.5\baselineskip}{\bf{Keywords:}~}
  }{
    \vspace{0.5em}{\bf{关键词:}}
  }
}{}
% 关键字分隔符 \sep
\newcommand{\sep}{\unskip; }

%%% 目录
\newcommand{\jncontents}{
  \cleardoublepage         % 目录从奇数页开始
  \samplepagestyle{\songti\zihao{5}目录} % 页面样式
  \tableofcontents                       % 目录
}

%%% 正文
\newcommand{\jnmainmatter}{
  \mainmatter
  \pagestyle{fancy}
  \fancyhead{}
  \fancyhead[CO]{\songti\zihao{5}\leftmark} % 奇数页页眉
  \fancyhead[CE]{\songti\zihao{5}江南大学{\thedegree}{\jndegree}论文} % 偶数页页眉
  \fancyfoot[C]{\thepage}    % 页码
  \headsep=0.5cm
}

% 致谢
\newcommand{\ackname}{致谢}
\newcommand{\jnacknowledgements}{
  \clearpage
  \samplepagestyle{\songti\zihao{5}\ackname}
  \chapter*{{\ziju{1}\ackname}}
  \addcontentsline{toc}{chapter}{致~~谢}
}

%%% 参考文献样式
\def\bstfile{jn}                    % 默认的 bst 文件名
\newcommand{\setbstfile}[1]{\def\bstfile{#1}}   % 设置 bst 文件命令
\def\bibfiles{references}           % 默认的 bib 文件名
\newcommand{\setbibfiles}[1]{\def\bibfiles{#1}} % 设置 bib 文件命令

% 参考文献
\newcommand{\jnreferences}{
  \clearpage
  \samplepagestyle{\songti\zihao{5}\bibname}
  \bibliographystyle{\bstfile} % 设定文献格式
  \bibliography{\bibfiles} % 多个文献数据库之间逗号隔开,不要空格
  \addcontentsline{toc}{chapter}{\bibname}
  \small
}

% 发表论文
\newcommand{\jnpublications}{
  \clearpage
  \samplepagestyle{\songti\zihao{5}附录}
  \chapter*{{\ziju{1}附录}: 作者在攻读{\thedegree}学位期间发表的论文}
  \addcontentsline{toc}{chapter}{附录: 作者在攻读{\thedegree}学位期间发表的论文}
}

%% 图标和表格英语标题
\RequirePackage[labelsep=quad, font={small}]{caption}
\RequirePackage{bicaption} % 双标题
\captionsetup[figure][bi-first]{name=图}
\captionsetup[figure][bi-second]{name=Figure}
\captionsetup[table][bi-first]{name=表}
\captionsetup[table][bi-second]{name=Table}

% 定理环境
\theoremheaderfont{\heiti}
\theorembodyfont{\songti}
\theoremnumbering{arabic}
\theoremseparator{\hspace{0.5em}}
\theorempreskip{5pt}
\theorempostskip{5pt}
\theoremsymbol{}

\theoremstyle{plain}
\newtheorem{theorem}{\hspace{2em}定理}[chapter]
\newtheorem{lemma}{\hspace{2em}引理}[chapter]
\newtheorem{proposition}{\hspace{2em}命题}[chapter]
\newtheorem{assumption}{\hspace{2em}假设}[chapter]
\newtheorem{corollary}{\hspace{2em}推论}[chapter]
\newtheorem{property}{\hspace{2em}性质}[chapter]
\newtheorem{axiom}{\hspace{2em}公理}[chapter]

% \theoremstyle{definition}
\newtheorem{definition}{\hspace{2em}定义}[chapter]
\newtheorem{example}{\hspace{2em}例}[chapter]

% \theoremstyle{remark}
\newtheorem{remark}{\hspace{2em}注}[chapter]

\theoremsymbol{$\square$}
\newtheorem*{proof}{\hspace{2em}证明}

% 公式格式
\allowdisplaybreaks[4] % 允许 align 公式跨页

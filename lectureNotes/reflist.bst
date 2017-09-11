%% 
%% This is file `reflist.bst', generated 
%% on <1995/3/14> with the docstrip utility (2.2i).
%% 
%% hacked to make max authors=5
%% The original source files were:
%% 
%% genbst.mbs  (with options: `,nm-init,nmlm,x3,m3,dt-beg,yr-par,yrp-x,vol-bf,edby,pp,ed,abr,etal-it')
%% ---------------------------------------- 
%% *** Bib style for ref lists etc.; abbrev, date-sorted (hack) *** 
%% 
%% (Here are the specifications of the source file)
%% \ProvidesFile{genbst.mbs}[1995/02/02 1.6 (PWD)]
%%   For use with BibTeX version 0.99a or later
%%     and with LaTeX 2.09 or 2e
%%-------------------------------------------------------------------
%% NOTICE:
%% This file may be used for non-profit purposes.
%% It may not be distributed in exchange for money,
%%   other than distribution costs.
%%
%% The author provides it `as is' and does not guarantee it in any way.
%%
%% Copyright (C) 1994, 1995 Patrick W. Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Postfach 20
%% D-37189 Katlenburg-Lindau
%% Germany
%%
%% E-mail:
%% SPAN--     nsp::linmpi::daly    (note nsp also known as ecd1)
%% Internet-- daly@linmpi.dnet.gwdg.de
%%-----------------------------------------------------------
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%---------------------------------------------------------------------
 % This is a numerical citation style, and as such is standard LaTeX.
 % It requires no extra package to interface to the main text.
 % The form of the \bibitem entries is
 %   \bibitem{key}...
 % Usage of \cite is as follows:
 %   \cite{key} ==>>          [#]
 %   \cite[chap. 2]{key} ==>> [#, chap. 2]
 % where # is a number determined by the ordering in the reference list.
 % This is alphabetical by authors.
%%---------------------------------------------------------------------

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {add.blank}
{ " " * before.all 'output.state :=
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {non.stop}
{ duplicate$
   "}" * add.period$
   #-1 #1 substring$ "." =
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * non.stop
        { "\/}" * }
        { "}" * }
      if$
    }
  if$
}

FUNCTION {bolden}
{ duplicate$ empty$
    { pop$ "" }
    { "{\bf " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
        {
          nameptr #6 =
          numnames #5 > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            {
              numnames #2 >
                { "," * }
                'skip$
              if$
              t "others" =
                { " " * "et~al." emphasize * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.names.ed}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{f.~}{vv~}{ll}{, jj}"
      format.name$ 't :=
      nameptr #1 >
        {
          namesleft #1 >
            { ", " * t * }
            {
              numnames #2 >
                { "," * }
                'skip$
              if$
              t "others" =
                { " " * "et~al." emphasize * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { " (eds.)" * }
        { " (ed.)" * }
      if$
    }
  if$
}

FUNCTION {format.in.editors}
{ editor empty$
    { "" }
    { editor format.names.ed
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {word.in}
{ "In " }

FUNCTION {format.date}
{ year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$
          month
        }
      if$
    }
    { month empty$
        'year
        { month " " * year * }
      if$
    }
  if$
  before.all 'output.state :=
  " (" swap$ * ")" *
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "vol." volume tie.or.space.connect
      series empty$
        'skip$
        { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "no." }
            { "No." }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " in " * series * }
          if$
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " edn." * }
        { edition "t" change.case$ " edn." * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { "pp." pages n.dashify tie.or.space.connect }
        { "p." pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  bolden
  number empty$
    'skip$
    {
      "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ":" * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "chap." }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { word.in booktitle emphasize * }
        { word.in booktitle emphasize *
          ", " *
          editor num.names$ #1 >
            { "eds." }
            { "ed." }
          if$
          * " " *
          format.in.editors *
        }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Tech. Rep." }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{
  key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$
          ""
        }
        { word.in journal emphasize * }
      if$
    }
    { word.in key * " " *}
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " " * "et~al." emphasize * }
    { #2 <
        'skip$
        { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { " " * "et~al." emphasize * }
            { " and " * editor #2 "{vv~}{ll}" format.name$ * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      word.in
    }
    { "Vol." volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { series empty$
            { "need editor, key, or series for " cite$ * " to crossref " *
              crossref * warning$
              "" *
            }
            { series emphasize * }
          if$
        }
        { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
              ""
            }
            { word.in booktitle emphasize * }
          if$
        }
        { word.in key * " " *}
      if$
    }
    { word.in format.crossref.editor * " " *}
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  format.date "year" output.check
  add.blank
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  format.date "year" output.check
  add.blank
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    {
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  format.date output
  add.blank
  format.title "title" output.check
  new.block
  howpublished output
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  format.date "year" output.check
  add.blank
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  format.date "year" output.check
  add.blank
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  format.date "year" output.check
  add.blank
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      address empty$
        { organization publisher new.sentence.checkb
          organization output
          publisher output
          format.date "year" output.check
        }
        { address output.nonnull
          new.sentence
          organization output
          publisher output
        }
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
        'skip$
        { organization output.nonnull
          address output
        }
      if$
    }
    { format.authors output.nonnull }
  if$
  format.date output
  add.blank
  format.btitle "title" output.check
  author empty$
    { organization empty$
    {
          address new.block.checka
          address output
        }
        'skip$
      if$
    }
    {
      organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  format.date "year" output.check
  add.blank
  format.btitle "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  format.date output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  new.block
  note output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  format.date "year" output.check
  add.blank
  format.btitle "title" output.check
  new.block
  "Ph.D. thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  format.date "year" output.check
  add.blank
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
        { publisher new.sentence.checka }
        { organization publisher new.sentence.checkb
          organization output
        }
      if$
      publisher output
    }
    { address output.nonnull
      new.sentence
      editor empty$
        'skip$
        { organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  format.date "year" output.check
  add.blank
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  format.date output
  add.blank
  format.title "title" output.check
  new.block
  note "note" output.check
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

 %-------------------------------------------------------------------
 % Begin module:
 % \ProvidesFile{eebjour.mbs}[1999/02/24 2.0d (PWD)]
MACRO {ab} {"Annals of Botany"}
MACRO {ap} {"Annals of Probability"}
MACRO {ajb} {"American Journal of Botany"}
MACRO {amn} {"American Midland Naturalist"}
MACRO {amnat} {"American Naturalist"}
MACRO {aap}  {"Annals of Applied Probability"}
MACRO {advap}  {"Advances in Applied Probability"}
MACRO {azf} {"Annales Zoologici Fennici"}
MACRO {ares} {"Annual Review of Ecology and Systematics"}
MACRO {arp} {"Annual Review of Phytopathology"}
MACRO {bmj} {"British Medical Journal"}
MACRO {bmb}  {"Bulletin of Mathematical Biology"}
MACRO {bms} {"Bulletin of Marine Science"}
MACRO {who} {"Bulletin of the World Health Organization"}
MACRO {cjb} {"Canadian Journal of Botany"}
MACRO {cjfas} {"Canadian Journal of Fisheries and Aquatic Sciences"}
MACRO {cjfr} {"Canadian Journal of Forest Research"}
MACRO {cjz} {"Canadian Journal of Zoology"}
MACRO {condor} {"Condor"}
MACRO {cb} {"Conservation Biology"}
MACRO {ce} {"Conservation Ecology"}
MACRO {ecol}  {"Ecology"}
MACRO {eapp}  {"Ecological Applications"}
MACRO {elet}  {"Ecology Letters"}
MACRO {emod}  {"Ecological Modelling"}
MACRO {emon}  {"Ecological Monographs"}
MACRO {evo}  {"Evolution"}
MACRO {eve}  {"Evolutionary Ecology"}
MACRO {eer}  {"Evolutionary Ecology Research"}
MACRO {fe}   {"Functional Ecology"}
MACRO {gcb}   {"Global Change Biology"}
MACRO {imaj}  {"IMA Journal of Mathematics Applied in Medicine and Biology"}
MACRO {jama} {"Journal of the American Medical Association"}
MACRO {jae} {"Journal of Animal Ecology"}
MACRO {jappe} {"Journal of Applied Ecology"}
MACRO {jbiog} {"Journal of Biogeography"}
MACRO {jeco} {"Journal of Ecology"}
MACRO {jmr} {"Journal of Marine Research"}
MACRO {jmb} {"Journal of Mathematical Biology"}
MACRO {jrssa} {"Journal of the Royal Statistical Society A"}
MACRO {jrssb} {"Journal of the Royal Statistical Society B"}
MACRO {jtb} {"Journal of Theoretical Biology"}
MACRO {jte} {"Journal of Tropical Ecology"}
MACRO {jvs} {"Journal of Vegetation Science"}
MACRO {mb}  {"Mathematical Biosciences"}
MACRO {mcna} {"Medical Clinics of North America"}
MACRO {nature} {"Nature"}
MACRO {oec} {"Oecologia"}
MACRO {oik} {"Oikos"}
MACRO {phta} {"Philosophical Transactions of the Royal Society A"}
MACRO {phtb} {"Philosophical Transactions of the Royal Society B: Biological Sciences"}
MACRO {pdid} {"Population Dynamics of Infectious Disease: Theory and Applications"}
MACRO {pnas} {"Proceedings of the National Academy of Sciences of the USA"}
MACRO {prsa} {"Proceedings of the Royal Society of London Series A"}
MACRO {prsb} {"Proceedings of the Royal Society of London Series B: Biological Sciences"}
MACRO {qrb} {"Quarterly Review of Biology"}
MACRO {rpe} {"Researches on Population Ecology"}
MACRO {science}  {"Science"}
MACRO {sjam} {"SIAM Journal of Applied Mathematics"}
MACRO {trstmh} {"Transactions of the Royal Society of Tropical Medicine and Hygiene"}
MACRO {tg} {"Trends in Genetics"}
MACRO {tpb} {"Theoretical Population Biology"}
MACRO {tree} {"Trends in Ecology and Evolution"}
MACRO {tm} {"Trends in Microbiology"}
MACRO {veg} {"Vegetatio"}
 % End module: eebjour.mbs

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr
      "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}"
      format.name$ 't :=
      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ year field.or.null sortify
  "    "
  * 
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
%% End of customized bst file 

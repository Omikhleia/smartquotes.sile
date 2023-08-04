--
-- Smart language-dependent quotations marks for SILE
-- License: MIT, (c) 2022-2023 Omikhleia
--
require("silex.lang")
local base = require("packages.base")

local package = pl.class(base)
package._name = "smartquotes"

-- The languages are ordered by their full name (end of line comment)
-- in English, for ease of comparison and check with that table.
--
-- The list is mainly derived from
--   https://en.wikipedia.org/wiki/Quotation_mark#Summary_table
-- Using the "Standard" table as of. Nov. 11, 2022
--
-- Some additional entries come from
--   https://op.europa.eu/en/web/eu-vocabularies/formex/physical-specifications/character-encoding/use-of-quotation-marks-in-the-different-languages
-- Called [EU-CHAR] in comments

local QuotationMarks = {
  --             Primary        Secondary
  af          = {'“',  '”',     '‘',  '’'    }, -- Afrikaans
  sq          = {'„',  '“',     '‚',  '‘'    }, -- Albanian
  am          = {'«',  '»',     '‹',  '›'    }, -- Amharic
  ar          = {'«',  '»',     nil,  nil    }, -- Arabic. LTR ORDER UNSURE!
  hy          = {'«',  '»',     nil,  nil    }, -- Armenian
  az          = {'«',  '»',     '„',   '“'   }, -- Azerbaijani
  eu          = {'«',  '»',     '“',   '”'   }, -- Basque
  be          = {'«',  '»',     '„',   '“'   }, -- Belarusian
  bs          = {'”',  '”',     '’',  '’'    }, -- Bosnian
  bg          = {'„',  '“',     '’',  '’'    }, -- Bulgarian N.B. [EU-CHAR] gives same primary and secondary forms
  ca          = {'«',  '»',     '“',  '”'    }, -- Catalan
  zh          = {'「', '」',     '『', '』'    }, -- Chinese (traditional, rotated for horizontal writing direction)
  -- hr       = {'„',  '”',     '‘',  '’'    }, -- Croatian [English Wikipedia]
  hr          = {'„',  '”',     '‚',  '’'    }, -- Croatian [EU-CHAR]
  -- hr       = {'„',  '”',     '’',  '’'    }, -- Croatian [sr.wikipedia.org, entry "Наводници"]
  cs          = {'„',  '“',     '‚',  '‘'    }, -- Czech
  da          = {'»',  '«',     '›',  '‹'    }, -- Danish N.B. [EU-CHAR] gives same primary and secondary forms
  nl          = {'“',  '”',     '‘',  '’'    }, -- Dutch N.B. [EU-CHAR] gives same primary and secondary forms
  en          = {'“',  '”',     '‘',  '’'    }, -- English (US)
  ['en-GB']   = {'‘',  '’',     '“',  '”'    }, -- English UK N.B. The only form mentioned in [EU-CHAR], LoL.
  ['en-CA']   = {'“',  '”',     '‘',  '’'    }, -- English Canadian
  eo          = {'“',  '”',     '‘',  '’'    }, -- Esperanto
  et          = {'„',  '“',     nil,  nil    }, -- Estonian N.B. [EU-CHAR] gives same primary and secondary forms
  fil         = {'“',  '”',     '‘',  '’'    }, -- Filipino
  fi          = {'”',  '”',     '’',  '’'    }, -- Finnish [EU-CHAR]
  fr          = {'«',  '»',     '“',  '”'    }, -- French (France)
  ['fr-CH']   = {'«',  '»',     '‹',  '›'    }, -- French Switzerland
  gl          = {'«',  '»',     '“',  '”',   }, -- Galician
  ka          = {'„',  '“',     nil,  nil    }, -- Georgian
  de          = {'„',  '“',     '‚',  '‘'    }, -- German (Germany)
  ['de-CH']   = {'«',  '»',     '‹',  '›'    }, -- German Switzerland
  el          = {'«',  '»',     '“',  '”'    }, -- Greek
  he          = {'"',  '"',     "'",  "'"    }, -- Hebrew
  hi          = {'“',  '”',     '‘',  '’'    }, -- Hindi
  hu          = {'„',  '”',     '»',  '«'    }, -- Hungarian
  is          = {'„',  '“',     '‚',  '‘'    }, -- Icelandic
  io          = {'«',  '»',     '‘',  '’'    }, -- Ido
  id          = {'“',  '”',     '‘',  '’'    }, -- Indonesian
  ia          = {'“',  '”',     '‘',  '’'    }, -- Interlingua
  ga          = {'“',  '”',     '‘',  '’'    }, -- Irish
  it          = {'«',  '»',     '“',  '”'    }, -- Italian (Italy)
  ['it-CH']   = {'«',  '»',     '‹',  '›'    }, -- Italian Switzerland
  ja          = {'「', '」',    '『',  '』'    }, -- Japanese (rotated for horizontal writing direction)
  kk          = {'«',  '»',     nil,  nil    }, -- Kazakh
  km          = {'«',  '»',     nil,  nil    }, -- Khmer
  ko          = {'《', '》',    '〈',  '〉'    }, -- Korean
  ['ko-KR']   = {'“',  '”',     '‘',  '’'    }, -- Korean (South Korea)
  lo          = {'“',  '”',     nil,  nil    }, -- Lao
  lv          = {'“',  '”',     '‘',  '’'    }, -- Latvian [EU-CHAR] (corresponding to modern use)
                                                --   The latter gives same primary and secondary forms, but Latvian Wikipedia
                                                --   mentions simple quotes [lv.wikipedia.org entry Pēdiņas]
  lt          = {'„',  '“',     nil,  nil    }, -- Lithuanian [EU-CHAR] N.B. [EU-CHAR] gives same primary and secondary forms
  jbo         = {                            }, -- Lojban (uses words, so let's not cover it)
  mk          = {'„',  '“',     '’',  '‘'    }, -- Macedonian
  mt          = {'“',  '”',     '‘',  '’'    }, -- Maltese
  mn          = {'«',  '»',     '‹',  '›'    }, -- Mongolian (when written in Cyrillic script)
  khb         = {'《', '》',    '〈',  '〉'    }, -- New Tai Lue
  no          = {'«',  '»',     '‘',  '’'    }, -- Norwegian
  oc          = {'«',  '»',     '“',  '”'    }, -- Occitan
  ps          = {'«',  '»',     nil,  nil    }, -- Pashto
  fa          = {'«',  '»',     nil,  nil    }, -- Persian
  pl          = {'„',  '”',     '»',  '«'    }, -- Polish
  pt          = {'«',  '»',     '“',  '”'    }, -- Portuguese (Portugal)
  ['pt-BR']   = {'“',  '”',     '‘',  '’'    }, -- Portuguese Brazil
  ro          = {'„',  '”',     '«',  '»'    }, -- Romanian
  rm          = {'«',  '»',     '‹',  '›'    }, -- Romansh
  ru          = {'«',  '»',     '„',  '“'    }, -- Russian
  sr          = {'„',  '“',     '’',  '’'    }, -- Serbian
  gd          = {'‘',  '’',     '“',  '”'    }, -- Scottish Gaelic
  sk          = {'„',  '“',     '‚',  '‘'    }, -- Slovak
  sl          = {'„',  '“',     '‚',  '‘'    }, -- Slovene
  wen         = {'„',  '“',     '‚',  '‘'    }, -- Sorbian
  es          = {'«',  '»',     '“',  '”'    }, -- Spanish
  ['es-MX']   = {'“',  '”',     '‘',  '’'    }, -- Spanish, Mexico
  sv          = {'”',  '”',     '’',  '’'    }, -- Swedish
  tdd         = {'《', '》',    '〈',  '〉'    }, -- Tai Le
  ta          = {'“',  '”',     '‘',  '’'    }, -- Tamil
  bo          = {'《', '》',    '〈',  '〉'    }, -- Tibetan
  ti          = {'«',  '»',     '‹',  '›'    }, -- Tigrinya
  th          = {'“',  '”',     '‘',  '’'    }, -- Thai
  tr          = {'“',  '”',     '‘',  '’'    }, -- Turkish
  uk          = {'«',  '»',     '“',  '”'    }, -- Ukrainian
  ur          = {'“',  '”',     '‘',  '’'    }, -- Urdu
  ug          = {'«',  '»',     '‹',  '›'    }, -- Uyghur
  uz          = {'«',  '»',     '„',  '“'    }, -- Uzbek
  vi          = {'“',  '”',     nil,  nil    }, -- Vietnamese
  cy          = {'‘',  '’',     '“',  '”'    }, -- Welsh
}

local InvertedQuotationRank = {
  ['en-GB'] = true,
  gd = true,
  cy = true,
}

---@return table|boolean
local function forLanguage(lang, lookupTable, default)
  if lookupTable[lang] ~= nil then
    return lookupTable[lang]
  end
  local res, _ = SILE.X.forLanguage(lang, lookupTable)
  lookupTable[lang] = res or default -- memoize
  return res or default
end

function package:registerCommands ()
  -- A. Commands (normally) intended to be used by this package only.

  self:registerCommand("primquoted", function (_, content)
    local lang = SILE.settings:get("document.language")
    local quotes = forLanguage(lang, QuotationMarks, {})
    if #quotes < 2 then
      SU.warn("No typographic primary quotes for language '" .. lang .. "'")
      SILE.typesetter:typeset('"')
      SILE.process(content)
      SILE.typesetter:typeset('"')
    else
      SILE.typesetter:typeset(quotes[1])
      SILE.process(content)
      SILE.typesetter:typeset(quotes[2])
    end
  end, "Wraps its content between language-dependent typographic primary quotes")

  self:registerCommand("secquoted", function (_, content)
    local lang = SILE.settings:get("document.language")
    local quotes = forLanguage(lang, QuotationMarks, {})
    if #quotes < 4 then
      SU.warn("No typographic secondary quotes for language '" .. lang .. "'")
      SILE.typesetter:typeset("'")
      SILE.process(content)
      SILE.typesetter:typeset("'")
    else
      SILE.typesetter:typeset(quotes[3])
      SILE.process(content)
      SILE.typesetter:typeset(quotes[4])
    end
  end, "Wraps its content between language-dependent typographic secondary quotes")

  self:registerCommand("doublequoted", function (options, content)
    local lang = SILE.settings:get("document.language")
    local inverted = forLanguage(lang, InvertedQuotationRank, false)
    local command = inverted and "secquoted" or "primquoted"
    SILE.call(command, options, content)
  end, "Wraps its content between language-dependent typographic double quotes")

  self:registerCommand("singlequoted", function (options, content)
    local lang = SILE.settings:get("document.language")
    local inverted = forLanguage(lang, InvertedQuotationRank, false)
    local command = inverted and "primquoted" or "secquoted"
    SILE.call(command, options, content)
  end, "Wraps its content between language-dependent typographic double quotes")
end

-- For other packages needing to know the quotation marks for a given language.
function package.quoteRules(_, lang)
  return forLanguage(lang, QuotationMarks, {}),
         forLanguage(lang, InvertedQuotationRank, false)
end

package.documentation = [[\begin{document}
The small \autodoc:package{smartquotes} package helps easily obtaining
appropriate typographic quotation marks according to the currently selected
language.

It provides four commands:

\begin{itemize}
\item{\autodoc:command{\primquoted{<content>}}}
\item{\autodoc:command{\secquoted{<content>}}}
\item{\autodoc:command{\doublequoted{<content>}}}
\item{\autodoc:command{\singlequoted{<content>}}}
\end{itemize}

The two first commands wrap their content between the appropriate typographic
primary and secondary quotation marks, where “primary” stands for the most
usual marks (coming at first quotation rank), and “secondary” the marks normally
used when inside an already quoted text (hence, at second quotation rank).
For instance, here are primary marks in \language[main=en]{\primquoted{US English}} /
\language[main=de]{\primquoted{Deutsch}} /
\language[main=fr]{\primquoted{français}}; and secondary marks in
\language[main=en]{\secquoted{US English}} / \language[main=de]{\secquoted{Deutsch}} /
\language[main=fr]{\secquoted{français}}.

The two last commands wrap their content between the closest typographic
equivalent marks for replacing double and single quotation marks,
taking into account that a few languages use single quotes as primary
marks.\footnote{There is not really such a thing as a “double” or “single” quote
in good typography usage, for printed texts.
The issue here is rather: What would one expect, as appropriate typographic
replacement for the straight double (") and single (') quotation marks in a given
language?
For most languages, we can just map them to the primary and secondary quotations
marks, respectively. In some languages, though, they are used the other way round.}
These convenience commands may find a use in supporting the so-called “smart typography”
feature with some text formats, such as Markdown.

Note that the language mappings are based on tables from several sources.
When the latter didn’t specify secondary marks, this package doesn’t try
to guess what a logical replacement might be, because bad typography shouldn’t be
the silent norm. Therefore, a warning is generated and straight (non-typographic)
characters are used.
\end{document}]]

return package

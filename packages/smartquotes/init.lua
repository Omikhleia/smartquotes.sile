--
-- Smart language-dependent quotations marks for SILE
-- License: MIT, (c) 2022 Omikhleia
--
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

function package:registerCommands ()
  -- A. Commands (normally) intended to be used by this package only.

  self:registerCommand("smartdoublequotes", function (_, content)
    local lang = SILE.settings:get("document.language")
    local quotes = QuotationMarks[lang]
    if not quotes or #quotes < 2 then
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

  self:registerCommand("smartsinglequotes", function (_, content)
    local lang = SILE.settings:get("document.language")
    local quotes = QuotationMarks[lang]
    if not quotes or #quotes < 4 then
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
end

package.documentation = [[\begin{document}
The small \autodoc:package{smartquotes} helper package allows you to easily
obtain typographic quotation marks according to the currently selected language.

It provides two commands, \autodoc:command{\smartdoublequotes{<content>}} and
\autodoc:command{\smartsinglequotes{<content>}}. They wrap their content between
the appropriate typographic quotation marks.

The language mappings derive from a table in the English Wikipedia. When that
table doesn’t specify secondary marks, this package doesn’t try to guess what
a logical replacement might be, because bad typography shouldn’t be the
silent norm. Therefore, a warning is generated and straight (non-typographic) character
are used.
\end{document}]]

return package

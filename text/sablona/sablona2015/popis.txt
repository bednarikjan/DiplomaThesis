Changelog původní šablony z roku 2009:
- do cls/fitthesis.cls pridany "SP" (semestralni projekt/term project)
- fontenc (aby se dalo copy/paste kopirovat z prace)
- formatovani citaci podle csn (viz. http://www.fit.vutbr.cz/~martinek/latex/czechiso.html.cs.iso-8859-2 )
- listoffigures, listoftables, appendix
- Rok pomoci \yyyydate
- parametr "print" pro \documentclass[print]{...}, ktery ve vyslednem vypne aktivni odkazy v pdf (na papire
  cerveny obsah vypada hodne divne)
- prevedeno do utf-8 (v linuxu je to default vsech editoru, windowsaci si nejak poradi)
- do komentare bylo pridane \listoffigures a \listoftables

sablona2015 má oproti původní šabloně z roku 2009:
- dokončenu změnu kódování na UTF8,
- doplněné vkládání zadání,
- úpravy, aby z PDF bylo možné kopírovat text,
- doplněnou variantu s černými odkazy pro tisk,
- vypnuté automatické nahrazování uvozovek, které dělá problémy v ukázkách kódu (pro české uvozovky lze použít \uv{}),
- přejmenované seznamy tabulek, obrázků a literatury,
- přílohy se jmenuji "Přílohy" a v nadpisu mají "Příloha"
- doplněn seznamem příloh,
- vylepšený seznam literatury
- literatura je v obsahu
- "školitel" pro disertační práci
- odstraněné desky (nově v IS FIT)

alternativaBib obsahuje alternativní styl pro BibTeX od Radima Loskota a příklad jeho použití.

Nascanované zadání je potřeba pojmenovat zadani.pdf - bude automaticky vloženo na správné místo.

Pro odevzdání do WISu má být v projekt.tex odkomentovaný řádek:
\documentclass[zadani,cover]{fitthesis}
pro tisk řádek
\documentclass[zadani,print]{fitthesis}

Pozor na zradu s číslováním stránek!!!
- Pokud má obsah 2 strany a na 2. jsou jen "Přílohy" a "Seznam příloh" (ale žádná příloha tam není), z nějakého důvodu se posune číslování stránek o 1 (obsah nesedí).
- Stejný efekt má, když je na 2. či 3. stránce obsahu jen "Literatura"
- Řešením je mít tolik řádků obahu, aby toho na 2. stránce bylo víc nebo nic, nebo přímo nastavit počítadlo.
- Možná toho problému lze dosáhnout i jinak - vždy je před odevzdáním lepší překontrolovat číslování stran!

Nezapomeňte, že vlna neřeší všechny nezalomitelné mezery. Vždy je třeba manuální kontrola, zda na konci řádku nezůstalo něco nevhodného - viz http://prirucka.ujc.cas.cz/?id=880 Na koncích řádků nevypadají dobře ani jednoslabičné spojky a předložky jako "do", "od", "po" apod. - dříve to bylo uvedeno na stejné stránce, ale protože se jedná o typografické doporučení a nikoliv o jazykovou zásadu, nyní to tam již není. Nicméně lze to najít v různých pokynech k vypracování maturitních, bakalářských, diplomových a jiných kvalifikačních prací a následně i v posudcích oponentů.

Užitečné balíčky pro LaTeX
--------------------------

Řešení problému, kdy klikací odkazy na obrázky vedou za obrázek:
\usepackage[all]{hypcap}

Rovnice:
\usepackage{amsmath}

Umístění obrázků:
\usepackage{float}
\usepackage{afterpage}

Úpravy vlastností Verbatim:
\usepackage{fancyvrb}

Rozšíření možností tabulek:
\usepackage{makecell}
\usepackage{tabularx}

Úpravy dělení slov:
\usepackage{hyphenat}

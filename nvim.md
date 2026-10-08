| Keys | Result |
| --- | --- |
| `*` / `#` | Search the whole word under the cursor forward / backward |
| `g*` / `g#` | Search the word without requiring whole-word boundaries |
| `/pattern` then Enter | Search forward |
| `?pattern` then Enter | Search backward |
| `n` / `N` | Repeat search in its original / opposite direction |
| `:noh` | Clear current search highlighting |
| `viw` | Select inner word |
| `yiw` | Copy inner word |
| `ciw` | Replace inner word, entering Insert mode |
| `diw` | Delete inner word |
| `viW` | Select a whitespace-delimited WORD, including punctuation |


| Keys | Result |
| --- | --- |
| `yaf` | Copy function |
| `daf` | Delete function |
| `cif` | Replace function body |
| `=af` | Reindent function using the buffer's indentation rules |
| `val` | Select loop |
| `vil` | Select loop body |
| `vai` | Select conditional |
| `vii` | Select conditional body |
| `cia` | Replace argument/parameter content |
| `daa` | Delete argument/parameter with its surrounding capture |
| `ci"` | Replace contents of double quotes; built in |
| `ci(` | Replace contents of parentheses; built in |
| `va{` | Select braces and their contents; built in |


| Keys | Use |
| --- | --- |
| `%` | Match paired delimiters such as parentheses and braces |
| `f<char>` / `F<char>` | Find a character right / left on this line |
| `t<char>` / `T<char>` | Move just before / after a character on this line |
| `;` / `,` | Repeat / reverse the last character-find motion |
| `.` | Repeat the last change |
| `u` / `<C-r>` | Undo / redo |
| `^` / `$` | First nonblank character / end of line |
| `gg` / `G` | Top / bottom of file |
| `zz` | Center the cursor line in the window |
| `<C-d>` / `<C-u>` | Scroll approximately half a screen down / up |
| `ma` then `'a` | Set mark a, then return to its line |
| `` `a `` | Return to mark a's exact position |
| `gv` | Reselect the previous visual selection |
| `"+y` after selecting text | Copy to system clipboard if clipboard support is available |
| `"+p` | Paste from system clipboard |






This is some text to pract1ce on, its pr3tty cOol

This is some text to pract1ce on, its long to be honest-

This is some rand0m bullshit to pract1ce on, its long to be honest-

```
def main(buffer: listint, str, bool) -> None:
    for i, s = enumerate(buffer):
        res = code(s)
        print(f"[{i}]{res.whatIsIt}, {res.itIs}\n")
        

def code(self, wow: int, this_is_pretty: str, cool: bool) -> result:
    not_sure = "what is this"

    if wow > 5:
        return result(not_sure + "cool thing", this_is_pretty + "cool")
    else:
        return result(not_sure + "eh thing", this_is_pretty + "shit")


def main(buffer: listint, str, bool) -> None:
    for i, s = enumerate(buffer):
        res = code(s)
        print(f"[{i}]{res.whatIsIt}, {res.itIs}\n")
        

def code(self, wow: int, this_is_pretty: str, cool: bool) -> result:
    not_sure = "what is this"

    if wow > 5:
        return result(not_sure + "cool thing", this_is_pretty + "cool")
    else:
        return result(not_sure + "eh thing", this_is_pretty + "shit")

```









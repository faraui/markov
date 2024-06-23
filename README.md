## NAME

markov - Markov algorithms interpreter and their largest library

## DESCRIPTION
Markov algorithms is a turing-complete string rewriting system. Hereafter, the description relates specifically to the Markov algorithms alteration implemented in this software.

A *word* is defined as a finite sequence of alphanumericals (i. e. A-Z, a-z and 0-9). An *empty word* is defined as a word with no alphanumericals. An empty word is denoted by ^.

A word **S** is said to be a *subword* of a word **W**, if **W = XSY**. For any word **W**, **W = ^W**.

A *substitution rule* is defined as two words separated with either space-dot-space or space-comma-space. The first one is called a *terminal substitution rule*, while the second one is called *non-terminal substitution rule*. In these terms, "substituion" can be ommited and it is hereafter. An *execution result of a rule* **L . R** or **L , R** on the word **W** is defined as a word **W**, in which the very first, leftmost subword **L** is substituted with **R**. If an execution result of a rule **L . R** or **L , R** on a certain word **W** is equal to the **W** itself (i. e., if **L** is not a subword of **W**), it is said that this execution rule is *unworkable* on word **W**.

A *Markov algorithm* is a finite list of rules, one per line. Its execution on word **W** is described as follows:
1. If each rule is unworkable on word **W**, the word **W** is the result of the current Markov algorithm execution.
2. If at least one rule is not unworkable on word **W**, execute the very first of them on word **W**.
3. If an executed rule was terminal, its result is also the result of the current Markov algorithm execution.
4. If an executed rule was non-terminal, process its result as a word **W**.

```forth
            ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┬╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┬╌╌╌╌╌╌╌╌╌ Out1
            ╎ 2             ╎ 2                    ╎ 2
   In ┏╍╍╍╍╍┷╍╍╍╍╍┓ 1 ┏╍╍╍╍╍┷╍╍╍╍╍┓ 1      1 ┏╍╍╍╍╍┷╍╍╍╍╍┓ 1
╌┬╌╌╌╌┨  L1 x R1  ┠╌╌╌┨  L2 x R2  ┠╌╌╌ ╸╸╸╌╌╌┨  Ln x Rn  ┠╌╌╌ Out2
 │    ┗╍╍╍╍╍┯╍╍╍╍╍┛   ┗╍╍╍╍╍┯╍╍╍╍╍┛          ┗╍╍╍╍╍┯╍╍╍╍╍┛
 │          ╎ 3             ╎ 3                    ╎ 3
 └╌╌╌╌╌╌╌╌╌╌┴╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┴╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
```

## STRUCTURE
```diff
[  25K] markov
!! [  753] LICENSE.txt
~~ [ 2.7K] README.md
~~ [  225] interp.awk
++ [   6K] markov.sh
-- [  10K] algorithms
~~ ~~ [   22] binary_to_preunary
~~ ~~ [ 6.6K] decimal_to_dekimal
~~ ~~ [ 1.7K] dekimal_to_decimal
~~ ~~ [  135] dekimal_to_unary
~~ ~~ [  118] division
~~ ~~ [   77] factorial
~~ ~~ [   49] greatest_common_divisor
~~ ~~ [  366] lenght
~~ ~~ [   87] multiplication
~~ ~~ [   46] neumann
~~ ~~ [   98] power
~~ ~~ [    6] prefix
~~ ~~ [   29] substraction
~~ ~~ [  300] suffix
~~ ~~ [    6] summation
~~ ~~ [   42] unary_compare
~~ ~~ [  503] unary_to_dekimal
-- [ 1.7K] sequences
~~ ~~ [  124] binary_to_decimal
~~ ~~ [  101] compare
~~ ~~ [  190] division
~~ ~~ [  235] factorial
~~ ~~ [  167] greatest_common_divisor
~~ ~~ [  196] multiplication
~~ ~~ [  213] power
~~ ~~ [  176] substraction
~~ ~~ [  173] summation

30 files, 3 directories
```

## INSTALLATION
```bash
git clone -q https://github.com/faraui/markov.git
cd markov
chmod ugo+x markov.sh
```

## SYNOPSIS

**./markov.sh** \[**-V**\|**\--version**\] \[**-u**\|**\--usage**\]
\[**-?**\|**-h**\|**\--help**\] \[**-rc**\|**\--reset-config**\]\
**./markov.sh** \[**-nc**\|**\--no-colors**\] \[**-c**\|**\--count**\]
\[**-v**\|**\--verbose**\] *algorithm-file* \...\
**./markov.sh** \[**-nc**\|**\--no-colors**\] \[**-c**\|**\--count**\]
\[**-v**\|**\--verbose**\] **-s**\|**\--sequence**
*algorithm-sequence-file* \...

## OPTIONS

**-V**, **\--version**

> Display a version message and exit immediately.

**-u**, **\--usage**

> Display a usage message and exit immediately.

**-?**, **-h**, **\--help**

> Display a help message and exit immediately.

**-nc**, **\--no-colors**

> Disable font colors and styles.\
> They are disabled whether or not this option is set, if any of these
> are true:
>
> > a\) **markov** output is not directed into the terminal\
> > b) user **echo** can not process escape-sequences

**-s**, **\--sequence**

> Process each passed file as an algorithm sequence rather than an
> algorithm.

## CONFIGURATION

The configuration allows each following option to be set or unset if not
passed as an argument:

> **\--no-colors**\
> **\--sequence**

Configuration is done by editing the configuration file.\
In line 4 of **markov.sh** the absolute path of the configuration file
is set.\
In the unmodified **markov.sh**, this absolute path is
**\~/.config/markov/markov.conf**.

The configuration file is set automatically once **markov.sh** is
launched, if any of these are true:

> a\) option **-rc**\|**\--reset-config** is passed\
> b) the configuration file is empty\
> c) the configuration file is not present\

In lines 10 of **markov.sh**, the data of the configuration file that
is thus set can be modified.\
In the unmodified **markov.sh**, this data is **NO_COLORS=0;
SEQUENCE=0**.\
With such configuration file data, each corresponding option is unset if
not passed as an argument.\
**1** written respectively in the configuration file will give the
opposite result for an option.

## EXAMPLES
Do not let these examples distract you from the fact that for all sequences, the number separator is a letter **a**.

![123](https://github.com/faraui/markov/assets/170811164/d14150f5-c7c8-4c24-9b70-90976df8c9fe)

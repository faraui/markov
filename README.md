# NAME

markov - Markov algorithms interpreter and their largest library

# DESCRIPTION
```forth
            ┌───────────────┬──────────────────────┬───────── Out1
            │ 1             │ 1                    │ 1
   In ┏━━━━━┷━━━━━┓ 2 ┏━━━━━┷━━━━━┓ 2      2 ┏━━━━━┷━━━━━┓ 2
─┬────┨  L1 x R1  ┠───┨  L2 x R2  ┠─── ╸╸╸───┨  Ln x Rn  ┠─── Out2
 │    ┗━━━━━┯━━━━━┛   ┗━━━━━┯━━━━━┛          ┗━━━━━┯━━━━━┛
 │          │ 3             │ 3                    │ 3
 └──────────┴───────────────┴──────────────────────┘

            ┌───────────────┬──────────────────────┬───────────────┬──── Out
            │ 1             │ 1                    │ 1             │ 1
   In ┏━━━━━┷━━━━━┓ 2 ┏━━━━━┷━━━━━┓ 2      2 ┏━━━━━┷━━━━━┓ 2 ┏━━━━━┷━━━━━┓
─┬────┨  L1 x R1  ┠───┨  L2 x R2  ┠─── ╸╸╸───┨  Ln x Rn  ┠───┨   ^ . ^   ┃
 │    ┗━━━━━┯━━━━━┛   ┗━━━━━┯━━━━━┛          ┗━━━━━┯━━━━━┛   ┗━━━━━━━━━━━┛
 │          │ 3             │ 3                    │ 3
 └──────────┴───────────────┴──────────────────────┘

```

# INSTALLATION
markov

# STRUCTURE
```diff
[  22K] markov
!! [  753] LICENSE.txt
~~ [ 2.7K] README.md
~~ [  244] interp.awk
~~ [  254] interp_count.awk
~~ [  254] interp_count_verbose.awk
~~ [  254] interp_verbose.awk
++ [ 5.2K] markov.sh
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

33 files, 3 directories
```

# SYNOPSIS

**./markov.sh** \[**-V**\|**\--version**\] \[**-u**\|**\--usage**\]
\[**-?**\|**-h**\|**\--help**\] \[**-rc**\|**\--reset-config**\]\
**./markov.sh** \[**-nc**\|**\--no-colors**\] \[**-c**\|**\--count**\]
\[**-v**\|**\--verbose**\] *algorithm-file* \...\
**./markov.sh** \[**-nc**\|**\--no-colors**\] \[**-c**\|**\--count**\]
\[**-v**\|**\--verbose**\] **-s**\|**\--sequence**
*algorithm-sequence-file* \...

# OPTIONS

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

**-c**, **\--count**

> Display the total number of applied substituion rules once their
> execution is complete.

**-v**, **\--verbose**

> Display local changes in the processed word after each substituion
> rule is applied.\
> Consider this option to be unset if a lot of substitution rules are
> expected to be applied.\
> To know whether to use this option, launch **markov** with
> **-c**\|**\--count** option in advance.

**-s**, **\--sequence**

> Process each passed file as an algorithm sequence rather than an
> algorithm.

# CONFIGURATION

The configuration allows each following option to be set or unset if not
passed as an argument:

> **\--no-colors**\
> **\--verbose**\
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

In lines 9-11 of **markov.sh**, the data of the configuration file that
is thus set can be modified.\
In the unmodified **markov.sh**, this data is **NO_COLORS=0; VERBOSE=0;
SEQUENCE=0**.\
With such configuration file data, each corresponding option is unset if
not passed as an argument.\
**1** written respectively in the configuration file will give the
opposite result for an option.

# FILES

**markov**

# ERRORS

**markov**

# EXIT STATUS

**markov**

# EXAMPLES

**markov**

# AUTHOR

**markov**

# SEE ALSO

**markov**

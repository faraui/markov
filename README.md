## NAME

markov - Markov algorithms interpreter and their largest library

## SYNOPSIS

**./markov.sh** \[**-V**\|**\--version**\] \[**-u**\|**\--usage**\]
\[**-?**\|**-h**\|**\--help**\] \[**-rc**\|**\--reset-config**\]\
**./markov.sh** \[**-nc**\|**\--no-colors**\] \[**-v**\|**\--verbose**\]
\[**-c**\|**\--count**\] *algorithm-file* \...\
**./markov.sh** \[**-nc**\|**\--no-colors**\] \[**-v**\|**\--verbose**\]
\[**-c**\|**\--count**\] **-s**\|**\--sequence**
*algorithm-sequence-file* \...

## DESCRIPTION

**markov**

## OPTIONS

**-V**, **\--version**

> Display the version message and exit immediately.

**-u**, **\--usage**

> Display a usage message and exit immediately.

**-?**, **-h**, **\--help**

> Display a help message and exit immediately.

**-nc**, **\--no-colors**

> Disable color escape sequences and proceed.\
> They are disabled whether or not this option is set, if any of these
> are true:
>
> > a\) **markov** output is not directed into the terminal\
> > b) user **echo** can not process escape-sequences

**-c**, **\--count**

> Display the number of applied substituion rules once the execution is
> complete.

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

## CONFIGURATION

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

## FILES

**markov**

## ERRORS

**markov**

## EXIT STATUS

**markov**

## EXAMPLES

**markov**

## AUTHOR

**markov**

## SEE ALSO

**markov**
